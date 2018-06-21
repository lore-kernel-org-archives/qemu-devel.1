Received: from eggs.gnu.org ([2001:4830:134:3::10]:43185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVy8a-0008Ia-Uq
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVy8X-0001qS-SO
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:52:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVy8X-0001q2-MG
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:52:25 -0400
References: <20180621031957.134718-1-eblake@redhat.com>
	<CAFEAcA8TjkgNrEGJ9Z_vmwD_Upf8sjRFms5jKZiV4fBHCsRJ2g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8711e504-5e47-e424-c41b-705f75702150@redhat.com>
Date: Thu, 21 Jun 2018 06:52:24 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8TjkgNrEGJ9Z_vmwD_Upf8sjRFms5jKZiV4fBHCsRJ2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/7] bitmap export over NBD
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

On 06/21/2018 04:03 AM, Peter Maydell wrote:
> On 21 June 2018 at 04:19, Eric Blake <eblake@redhat.com> wrote:
>> The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a93b:
>>
>>    Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into staging (2018-06-20 09:51:30 +0100)
>>
>> are available in the Git repository at:
>>
>>    git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-06-20
>>
>> for you to fetch changes up to 5bde4bbbd1e217c323551d2785a0efff6340d840:
>>
>>    docs/interop: add nbd.txt (2018-06-20 21:20:05 -0500)
>>
>> ----------------------------------------------------------------
>> nbd patches for 2018-06-20
>>
>> Add experimental x-nbd-server-add-bitmap to expose a disabled
>> bitmap over NBD, in preparation for a pull model incremental
>> backup scheme.
>>
>> - Eric Blake: tests: Simplify .gitignore
>> - Vladimir Sementsov-Ogievskiy: 0/6 NBD export bitmaps
>>
> 
> The patchew errors for this pullreq look like they're real --
> do you want to fix them up and resend?

False positive, but I will respin to silence it, and to fix an 
independent issue that Vladimir found.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
