Received: from eggs.gnu.org ([2001:4830:134:3::10]:45778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GMy-0000nI-VN
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GMv-0008Eb-Sp
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:40:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46823)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f4GMv-0008Dy-NL
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:40:45 -0400
Date: Thu, 5 Apr 2018 21:40:44 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180406014044.GC25706@flamenco>
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-16-git-send-email-cota@braap.org>
	<87muyq7tnj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87muyq7tnj.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 15/16] translate-all: remove tb_lock
 mention from cpu_restore_state_from_tb
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

On Thu, Mar 29, 2018 at 17:06:56 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > tb_lock was needed when the function did retranslation. However,
> > since fca8a500d519 ("tcg: Save insn data and use it in
> > cpu_restore_state_from_tb") we don't do retranslation.
> >
> > Get rid of the comment.
> 
> I think we need to modify the comment in cpu_restore_state as well:
> 
>   Either way we need return early as we can't resolve it here.

Thanks, I've added this suggestion to patch 16/16.

		E.
