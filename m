Received: from eggs.gnu.org ([2001:4830:134:3::10]:51020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKRmG-0003W4-25
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKRmC-0004vZ-6b
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:38:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gKRmB-0004st-SB
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:38:00 -0500
References: <1541607585-15570-1-git-send-email-george.kennedy@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd38afdb-2f45-3f87-90c5-8a8b08fa5354@redhat.com>
Date: Wed, 7 Nov 2018 18:37:52 +0100
MIME-Version: 1.0
In-Reply-To: <1541607585-15570-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5] lsi: Reselection needed to remove
 pending commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: George Kennedy <george.kennedy@oracle.com>, famz@redhat.com, qemu-devel@nongnu.org, boris.ostrovsky@oracle.com

On 07/11/2018 17:19, George Kennedy wrote:
> +                if (s->want_resel && s->resel_dsp) {
> +                    save_dsp = s->dsp;
> +                    s->dsp = s->resel_dsp;
> +                    s->want_resel = false;
> +                }
>                  break;

Almost... this should be in lsi_reselect, and should be replaced by a
call to lsi_reselect.

Paolo
