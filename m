Received: from eggs.gnu.org ([2001:4830:134:3::10]:55427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1etxcD-0007Hk-GR
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1etxc8-0003g1-Ae
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:37:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1etxc8-0003fd-14
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:37:52 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w28FZmK1081067
	for <qemu-devel@nongnu.org>; Thu, 8 Mar 2018 10:37:49 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gk4aq2nw5-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 10:37:49 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 8 Mar 2018 15:37:47 -0000
References: <7c67e799-f4d8-6bf5-004e-6e1106fe053a@de.ibm.com>
	<20180308152603.x6ysyb4vq5py67mb@sirius.home.kraxel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 8 Mar 2018 16:37:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180308152603.x6ysyb4vq5py67mb@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1befeac9-9468-3604-a9c2-df321453ffd9@de.ibm.com>
Subject: Re: [Qemu-devel] qemu crashes with vnc and multiple outputs +
 console redirection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>



On 03/08/2018 04:26 PM, Gerd Hoffmann wrote:
>   Hi,
> 
>> I am playing with the virtio-gpu support on s390 and for that I also wanted to multiplex
>> the existing consoles.
>> So I basically used the max_outputs=2 of virtio gpu to be able
>> to switch with ctrl+alt+1 and 3 between the virtio gpu and the sclplm console.
> 
> Why max_outputs=2?  Do you want two fbdev devices?

I had the situation that the vc device does not appear via vnc
(only the virtio-gpu was then available). But I can no longer reproduce. So
with max_outputs=1 this now works as well. No idea what was wrong. And here
I can no longer see the crash.

> 
>> -chardev pty,id=charconsole0 -device sclpconsole,chardev=charconsole0,id=console0
>> -chardev vc,id=charconsole1 -device sclplmconsole,chardev=charconsole1,id=console1
>> -device virtio-keyboard-ccw,id=input0,devno=fe.0.0001
>> -vnc 0.0.0.0:0
>> -k en-us
>> -device virtio-gpu-ccw,id=video0,max_outputs=2,devno=fe.0.0008 
>>
>>
>> This seems to work fine, vrtio-gpu is on 1 and sclplm is on 3. Problem is, 
>> when I randomly do ctrl+alt+[^1..9] sooner or later qemu crashes with
> 
> Any chance this is ctrl-alt-2 ?

yes.
