Received: from eggs.gnu.org ([2001:4830:134:3::10]:45963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erpMs-0007uj-54
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erpMp-0002Vw-BK
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:25:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erpMp-0002Vi-6S
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:25:15 -0500
References: <20180302153205.9107-1-eblake@redhat.com>
	<CAFEAcA_bJRe-iWra+8othHo0xo1TYjKp3mmU2TF1Buab1==7LQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d25dba6-c7b0-e7aa-e7c4-61c51b3e3d01@redhat.com>
Date: Fri, 2 Mar 2018 12:25:08 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bJRe-iWra+8othHo0xo1TYjKp3mmU2TF1Buab1==7LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v3 00/30] QAPI patches for 2018-03-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 03/02/2018 10:55 AM, Peter Maydell wrote:
> On 2 March 2018 at 15:31, Eric Blake <eblake@redhat.com> wrote:
>> The following changes since commit 2e7b766594e17f786a6b2e5be690bc5b43ce6036:
>>
>>    Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-03-01' into staging (2018-03-02 12:39:13 +0000)
>>
>> are available in the Git repository at:
>>
>>    git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-01-v3
>>
>> for you to fetch changes up to cfe6a7fc6da20349ef62966c437f18ed6c49fcd5:
>>
>>    qapi: Don't create useless directory qapi-generated (2018-03-02 09:01:40 -0600)
>>
>> v3: (attempt to) fix warnings about empty .o files on OSX toolchain [Peter]
>> (sending just the changed patch)
>>
>> ----------------------------------------------------------------
>> qapi patches for 2018-03-01
>>
>> - Markus Armbruster: Modularize generated QAPI code
>>
> 
> As I suspected, this isn't sufficient to silence the warnings.

So 'static char' wasn't enough to create an export table, and I have to 
actually export something (while still ensuring it does not collide). 
Okay, I'll work up a v4 along those lines.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
