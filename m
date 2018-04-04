Received: from eggs.gnu.org ([2001:4830:134:3::10]:55837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3rdm-0008Ii-Mc
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3rdj-0005og-IV
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:16:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f3rdj-0005oQ-E9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:16:27 -0400
Date: Wed, 4 Apr 2018 19:16:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180404231626.GA28937@flamenco>
References: <1522883475-27858-1-git-send-email-cota@braap.org>
	<1522883475-27858-14-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522883475-27858-14-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v3 13/15] hardfloat: support float32/64
 fused multiply-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Wed, Apr 04, 2018 at 19:11:13 -0400, Emilio G. Cota wrote:
(snip)
> +        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
> +                   (soft_t ## _is_normal(b) || soft_t ## _is_zero(b)) && \
> +                   (soft_t ## _is_normal(c) || soft_t ## _is_zero(c)) && \

This is outdated wrt to the v3 tree on github. Changed there to:


-        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
-                   (soft_t ## _is_normal(b) || soft_t ## _is_zero(b)) && \
-                   (soft_t ## _is_normal(c) || soft_t ## _is_zero(c)) && \
+        if (likely(soft_t ## _is_zero_or_normal(a) &&                   \
+                   soft_t ## _is_zero_or_normal(b) &&                   \
+                   soft_t ## _is_zero_or_normal(c) &&                   \

		E.
