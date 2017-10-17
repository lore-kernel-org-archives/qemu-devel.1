Received: from eggs.gnu.org ([2001:4830:134:3::10]:35513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4NXS-00018A-Oy
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4NXN-0002Kk-T8
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:47:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e4NXN-0002J8-NG
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:47:45 -0400
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016165916.GI3246@localhost.localdomain>
	<4c14ed02-1f1c-a093-52ac-632f61a68a6f@redhat.com>
	<20171016171752.GK3246@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32f5d2bc-cf8f-727b-67bc-9611e9b6f7d0@redhat.com>
Date: Tue, 17 Oct 2017 10:47:40 +0200
MIME-Version: 1.0
In-Reply-To: <20171016171752.GK3246@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/6] CLI: add -paused option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, cohuck@redhat.com

On 16/10/2017 19:17, Eduardo Habkost wrote:
>> Should (or could) "-M none" be changed in a backwards-compatible way to
>> allow such preconfiguration?  For example
>>
>>   qemu -M none -monitor stdio
>>   (qemu) machine-set-options pc,accel=kvm
>>   (qemu) c
> Sounds like an interesting idea.  It would require ensuring it's
> really safe to destroy current_machine/accel (and other global
> state) and replace them with another object on the fly (which is
> probably a nice goal by itself).

It is but, alternatively, you could delay creating the "none" machine
until the last second.  The important part, in my opinion, is having a
good command-line interface that we can freeze even if the
implementation below leaves something to be desired.

Paolo
