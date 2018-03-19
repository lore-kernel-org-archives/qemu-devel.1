Received: from eggs.gnu.org ([2001:4830:134:3::10]:55167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exwPI-0004nC-TE
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exwPF-0005sO-LV
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:09:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1exwPF-0005rc-HI
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:09:01 -0400
References: <20180316144047.30904-1-nia.alarie@gmail.com>
	<a89c0265-53a0-a708-11fd-1096b565776b@redhat.com>
	<CA+k8WDrcRro0ifJC1AEKeyapMGL4VUbD05D4wGN6T9ySy0Wh7Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aafd7703-47a1-981b-095d-cba47e0bf054@redhat.com>
Date: Mon, 19 Mar 2018 10:08:47 -0500
MIME-Version: 1.0
In-Reply-To: <CA+k8WDrcRro0ifJC1AEKeyapMGL4VUbD05D4wGN6T9ySy0Wh7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] audio: Convert use of atoi to qemu_strtoi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: nee <nia.alarie@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, kraxel@redhat.com

On 03/19/2018 10:01 AM, nee wrote:
> On Mon, Mar 19, 2018 at 2:47 PM, Eric Blake <eblake@redhat.com> wrote:
>> On 03/16/2018 09:40 AM, Nia Alarie wrote:
>>>
>>> If qemu_strtoi indicates an error, return the default value.
>>
>>
>> Would it be better to diagnose the error instead of silently returning a
>> default value?
>>

> 
> Possibly, while writing these patches I was just going by what was
> already there. I can see how that would be good.
> 
> Should the code provide a warning to the user and continue with the
> default, or provide the warning and exit? And is it more correct to
> use dolog() or AUD_log() in this context?

I'll defer to the audio maintainer's opinion on what might be best here. 
  But my personal preference is that if the only time you can give 
invalid input is via a bad command line argument, then print the error 
and exit immediately (the VM never starts), so that the user can then 
fix their bad command line and get the value they wanted instead of 
silently running with a different value all because of a typo that 
caused us to fail to parse a number.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
