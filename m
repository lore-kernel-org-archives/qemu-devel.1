Received: from eggs.gnu.org ([2001:4830:134:3::10]:41722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0T22-0006eJ-8j
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0T1z-0003cF-JD
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:23:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0T1z-0003bl-CC
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:23:27 -0400
References: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA8-2uHpdPYHbKj3fTyPd4DEXHm2CF-xVGcg5nJfzF8RDQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b924dcf-d5bb-d1d9-a570-5fffd6a8db92@redhat.com>
Date: Mon, 26 Mar 2018 09:23:25 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-2uHpdPYHbKj3fTyPd4DEXHm2CF-xVGcg5nJfzF8RDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 03/26/2018 08:14 AM, Peter Maydell wrote:
> On 26 March 2018 at 08:00, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit 7b1db0908d88f0c9cfac24e214ff72a860692e23:
>>
>>    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180323' into staging (2018-03-25 13:51:33 +0100)
>>
>> are available in the git repository at:
>>
>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to 7587855cd23755a7a6bd01b026611465f5584ecd:
>>
>>    net/vde: print error on vde_open() failure (2018-03-26 14:52:43 +0800)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
>> Greg Kurz (1):
>>        virtio_net: flush uncompleted TX on reset
>>
>> Julia Suvorova via Qemu-devel (1):
>>        net/vde: print error on vde_open() failure
> 
> Applied, thanks.

We'll want a followup patch to .mailmap to make the git log attribution 
look nicer.  We currently have the following patches all attributed to 
the same email address; I have no idea if .mailmap can correctly sort 
between them:

$ git shortlog origin --author=qemu-devel | grep '^[^ ]'
Ed Swierk via Qemu-devel (2):
Ian McKellar via Qemu-devel (1):
Julia Suvorova via Qemu-devel (1):
Justin Terry (VM) via Qemu-devel (8):
Paul Donohue (2):

but it would be nice if we can improve our tooling to prevent future 
instances of the recurring problem.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
