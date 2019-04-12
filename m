Received: from eggs.gnu.org ([209.51.188.92]:53895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hExQL-0005Nh-8I
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hExQH-0004S2-JT
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:44:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:34466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hExQH-0004P2-9K
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:44:57 -0400
Received: by mail-wr1-x42d.google.com with SMTP id p10so12328696wrq.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:44:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1555072669-20441-1-git-send-email-puwen@hygon.cn>
	<20190412132420.GM25308@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5f6cbe5-5c60-9c5e-5218-63913f5ce616@redhat.com>
Date: Fri, 12 Apr 2019 16:44:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190412132420.GM25308@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RFC] i386: Add new Hygon 'Dhyana' and
 'Dhyana-IBPB' CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Pu Wen <puwen@hygon.cn>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, rth@twiddle.net

On 12/04/19 15:24, Daniel P. Berrangé wrote:
>> Add two new base CPU models called 'Dhyana' and 'Dhyana-IBPB' to model
>> processors from Hygon Dhyana (family 18h), which derived from AMD EPYC
>> (family 17h). 'Dhyana-IBPB' is a copy of the 'Dhyana' CPU model with
>> just CPUID_8000_0008_EBX_IBPB added.
> 
> Do we really need to support both CPU variants ?

Also, I think the compatibility properties are not needed for Dhyana chips.

Paolo
