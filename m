Received: from eggs.gnu.org ([2001:4830:134:3::10]:41408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOlH6-0002r2-8n
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOlH4-0001ik-Tc
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:11:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eOlH4-0001ht-OS
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:11:10 -0500
References: <20171211001950.27843-1-samuel.thibault@ens-lyon.org>
	<f0cb9660-757c-385f-ace7-73330014e733@redhat.com>
	<20171211145126.x3kxccyso7irle6x@var.youpi.perso.aquilenet.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0bf2c54e-da27-3c2c-a6c5-6802e6b466c4@redhat.com>
Date: Tue, 12 Dec 2017 15:11:05 +0100
MIME-Version: 1.0
In-Reply-To: <20171211145126.x3kxccyso7irle6x@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] baum: Truncate braille device size to 84x1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

On 11/12/2017 15:51, Samuel Thibault wrote:
>> Is magic clamping desirable, or is it better to make it a hard error if
>> the user configured a size that is not possible?
> The thing is: the user didn't configure something, she just happened to
> use a braille device bigger than 84 to display qemu's braille output.

Makes sense, I clarified the commit message to

    Baum device bigger than 84 do not actually exist, but the user's own
    Braille device might be wider than 84 columns.  Some guest drivers
    would be upset by such sizes, so clamp the device size.

Thanks,

Paolo
