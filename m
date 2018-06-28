Received: from eggs.gnu.org ([2001:4830:134:3::10]:55723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYWy6-000759-R5
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYWy1-0007P5-Ka
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:28:14 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYWy1-0007OE-E0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:28:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id c5-v6so5528738wrs.10
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 06:28:09 -0700 (PDT)
References: <20180607101019.14958-1-berrange@redhat.com>
	<20180628131722.GA13766@redhat.com>
	<8964dea3-042d-2eac-0198-d50c9c8947fc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <03c1e60e-6f5b-51cb-afe1-9f4e26a2c56b@redhat.com>
Date: Thu, 28 Jun 2018 15:28:06 +0200
MIME-Version: 1.0
In-Reply-To: <8964dea3-042d-2eac-0198-d50c9c8947fc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] doc: switch to modern syntx for VNC TLS
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org

On 28/06/2018 15:22, Eric Blake wrote:
>>>
>>> -qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509=/etc/pki/qemu
>>> -monitor stdio
>>> +qemu-system-i386 [...OPTIONS...] \
>>> +  -object
>>> tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=no
>>> \
> 
> I'd use --object here (especially since -object cannot be used on
> qemu-nbd, but --object tls-creds-x509 can).

But that would be inconsistent with -vnc.

I honestly don't understand the crusade against single-dashed options.

Paolo

>>> +  -vnc :1,tls-creds=tls0 -monitor stdio 
