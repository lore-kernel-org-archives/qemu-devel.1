Received: from eggs.gnu.org ([2001:4830:134:3::10]:60748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f48Pc-0006yA-Pq
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f48PY-0003WA-J9
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:11:00 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f48PY-0003Vo-BT
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:10:56 -0400
Date: Thu, 5 Apr 2018 13:10:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180405171054.GA15681@flamenco>
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-3-git-send-email-cota@braap.org>
	<87605g88je.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87605g88je.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 02/16] qht: return existing entry when
 qht_insert fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On Wed, Mar 28, 2018 at 17:33:09 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > -bool qht_insert(struct qht *ht, void *p, uint32_t hash);
> > +void *qht_insert(struct qht *ht, void *p, uint32_t hash);
> 
> Hmm this seems needlessly counter intuitive. I realise the potential
> efficiency in overloading success/fail but wouldn't a:
> 
>   bool qht_insert(struct qht *ht, void *p, uint32_t hash, void **existing);
> 
> be conceptually nicer?

Good point, fixed in v2.

Thanks,

		E.
