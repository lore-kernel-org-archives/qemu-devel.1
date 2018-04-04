Received: from eggs.gnu.org ([2001:4830:134:3::10]:56295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3rf1-0000n4-Hk
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3rf0-0006ZC-Ns
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:17:47 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f3rf0-0006Yw-J7
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:17:46 -0400
Date: Wed, 4 Apr 2018 19:17:45 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180404231745.GB28937@flamenco>
References: <1522883475-27858-1-git-send-email-cota@braap.org>
	<1522883475-27858-15-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522883475-27858-15-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v3 14/15] hardfloat: support float32/64
 square root
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

On Wed, Apr 04, 2018 at 19:11:14 -0400, Emilio G. Cota wrote:
(snip)
> +        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \

Updated on the github tree to:
-        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
+        if (likely(soft_t ## _is_zero_or_normal(a) &&                   \

All the other patches in this series are identical to the v3 on github.
Apologies for the last-minute mismatch on my end.

		Emilio
