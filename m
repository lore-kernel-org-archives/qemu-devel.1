Received: from eggs.gnu.org ([2001:4830:134:3::10]:45848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXA59-00009Z-TS
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXA56-00027H-40
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:17:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eXA55-00025o-Qq
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:17:31 -0500
References: <20180104175609.9085-1-pbonzini@redhat.com>
	<87448218.845975.1515089623014.JavaMail.zimbra@oxygem.tv>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <408c2559-4654-00bc-9b43-9e77989e5be5@redhat.com>
Date: Thu, 4 Jan 2018 19:17:28 +0100
MIME-Version: 1.0
In-Reply-To: <87448218.845975.1515089623014.JavaMail.zimbra@oxygem.tv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] add a blog post about "Spectre"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, ehabkost <ehabkost@redhat.com>

On 04/01/2018 19:13, Alexandre DERUMIER wrote:
> Thanks Paolo !
> 
> Do we need to update guest kernel too, if qemu use cpumodel=qemu64 ?
> 
> (For example,  I have some very old guests where kernel update is not possible)

If you want to be protected against the other two CVEs (one of which is
"Meltdown"), yes.

Paolo

> Regards,
> 
> Alexandre
