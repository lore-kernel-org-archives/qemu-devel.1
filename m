Received: from eggs.gnu.org ([2001:4830:134:3::10]:47312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQVZT-0000DX-5a
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQVZO-0005VR-AD
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:44:51 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cQVZO-0005UH-4c
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:44:46 -0500
Received: by mail-wm0-x243.google.com with SMTP id l2so20370259wml.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 00:44:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <a50ea1f9-4167-cc3f-f81c-61bd6a1853b7@freebsd.org>
	<d362b1ba-0c36-bc68-44e5-b3e55f3853e9@redhat.com>
	<97e4fa7a-2a66-e530-84d1-0c11fa11c305@freebsd.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d237d59f-e139-3f86-1656-58af0a6039c4@redhat.com>
Date: Mon, 9 Jan 2017 09:45:01 +0100
MIME-Version: 1.0
In-Reply-To: <97e4fa7a-2a66-e530-84d1-0c11fa11c305@freebsd.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [scripts] default shell/perl locations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sean Bruno <sbruno@freebsd.org>, qemu-devel@nongnu.org



On 06/01/2017 17:01, Sean Bruno wrote:
> 
> 
> On 01/06/17 01:14, Paolo Bonzini wrote:
>>
>>
>> On 05/01/2017 23:41, Sean Bruno wrote:
>>> I don't suppose it would be possible to have configure check/change the
>>> interpreter path for scripts so that operating systems that don't have
>>> /usr/bin/perl for example, would work out of the box?
>>
>> We can use
>>
>> #!/bin/sh
>> eval 'exec perl -x -wS $0 ${1+"$@"}'
>>     if 0;
>>
>> if that works for you.
> 
> that would be far superior, thank you.
> 
> This at least lets folks with /usr/local/bin/perl in their path, find
> and run scripts.

Great, then patches are welcome. :)

Paolo
