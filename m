Received: from eggs.gnu.org ([2001:4830:134:3::10]:38946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV1ju-0003Hj-QO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV1jr-0000mh-Nl
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:26:34 -0400
Received: from chuckie.co.uk ([82.165.15.123]:34937
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV1jr-0000lO-Fv
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:26:31 -0400
References: <1499803333-9052-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499803333-9052-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170711201059.GA6020@localhost.localdomain>
	<20170711231709-mutt-send-email-mst@kernel.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d9870097-46dc-40bf-49e9-7cf3276017f2@ilande.co.uk>
Date: Tue, 11 Jul 2017 21:26:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170711231709-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv8 1/3] fw_cfg: switch fw_cfg_find() to
 locate the fw_cfg device by type rather than path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On 11/07/17 21:18, Michael S. Tsirkin wrote:

> Multi-line comments also should formatted
> 
> /*
>  * like
>  * this
>  */
> 
> not
> 
> /* like
>  * this */
> 

Interesting, I never knew there was a preferred format for comments (I
see both styles throughout the codebase).

FWIW it's probably worth pointing out that the style for multi-line
comments isn't given in CODING_STYLE, and checkpatch didn't complain
either...


ATB,

Mark.
