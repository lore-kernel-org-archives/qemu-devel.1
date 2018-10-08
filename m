Received: from eggs.gnu.org ([2001:4830:134:3::10]:51707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9b2I-00029y-Rr
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9b2F-0007ql-N6
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:17:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g9b2F-0007qO-F7
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:17:43 -0400
References: <CAG48ez2Rq18M+a84Ae+N5_=eS2A6zZNrG9r19MWS6hddq=x4Rw@mail.gmail.com>
	<CAFEAcA_+oq2H=-_7+AxqpXb_VhUsSAgVgN8K7Q+ffeKXxs5gWQ@mail.gmail.com>
	<CAG48ez2CkA4jS8WiJ7Yj6dTsvoC_ozNdoQeOXxfg7JmRaK8srw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0aadcc23-ae86-bb04-a7e2-be654fe5144a@redhat.com>
Date: Mon, 8 Oct 2018 14:17:39 -0500
MIME-Version: 1.0
In-Reply-To: <CAG48ez2CkA4jS8WiJ7Yj6dTsvoC_ozNdoQeOXxfg7JmRaK8srw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] insecure git submodule URLs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jann Horn <jannh@google.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: jeff@codyprime.org, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 7/15/18 7:56 PM, Jann Horn via Qemu-devel wrote:
> On Sun, Jul 15, 2018 at 11:18 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On 15 July 2018 at 20:50, Jann Horn via Qemu-devel
>> <qemu-devel@nongnu.org> wrote:
>>> I noticed that when I build QEMU from git for the first time, it pulls
>>> in submodules over the insecure git:// protocol - in other words, as
>>> far as I can tell, if I'm e.g. on an open wifi network while building
>>> QEMU for the first time, even if I cloned the main repository over
>>> https, anyone could smuggle in malicious code as part of e.g. a
>>> submodule's makefile.
>>
>> Yes, this came up the other week.
>>
>>> I'm not sure what your preferred fix for this is, so I'm not sending a
>>> patch yet. As far as I can tell, the two options are:
>>>
>>>   - change .gitmodules to use https for everything
>>
>> We should probably do this...
>>

>>> As far as I can tell, the QEMU git server only supports the "dumb" git
>>> protocol when accessed over HTTPS, not the "smart" protocol. I'm not
>>> sure whether that might be why QEMU is currently still using the
>>> insecure git protocol instead of git over HTTPS?
>>
>> This is why we haven't switched over the submodules yet, yes.
>> It's on Jeff's todo list for the server, though.

Did we ever get this done? (And updating this thread to pull in Jeff's 
new email). (Reminded of this now that there is yet another submodule 
being proposed for mirroring)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
