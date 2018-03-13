Received: from eggs.gnu.org ([2001:4830:134:3::10]:36263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evmsF-0006vz-HF
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evmsC-0003BV-BJ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:34:03 -0400
References: <20180207155837.92351-1-vsementsov@virtuozzo.com>
	<20180207155837.92351-6-vsementsov@virtuozzo.com>
	<20180312153020.GI3219@work-vm>
	<af82d663-f37c-2857-214c-83e348a5f52a@virtuozzo.com>
	<20180313103056.GB3545@work-vm>
	<9bc43da5-027a-cd11-0c13-b9a9432e0fdb@virtuozzo.com>
	<20180313153513.GG3545@work-vm>
	<9f65e973-d3d3-09bf-5cf0-eac8d9e20b97@virtuozzo.com>
	<3a057d44-13e0-b208-cdce-96884bc03952@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <76f42ea0-86df-a389-568c-95f31a57f1da@virtuozzo.com>
Date: Tue, 13 Mar 2018 19:33:51 +0300
MIME-Version: 1.0
In-Reply-To: <3a057d44-13e0-b208-cdce-96884bc03952@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v10 05/12] migration: introduce
 postcopy-only pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, den@openvz.org, lirans@il.ibm.com

13.03.2018 19:16, John Snow wrote:
>
> On 03/13/2018 12:14 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Hmm, I agree, it is the simplest thing we can do for now, and I'll
>> rethink later,
>> how (and is it worth doing) to go to postcopy automatically in case of
>> only-dirty-bitmaps.
>> Should I respin?
> Please do. I already staged patches 1-4 in my branch, so if you'd like,
> you can respin just 5+.
>
> https://github.com/jnsnow/qemu/tree/bitmaps
>
> --js

Ok, I'll base on your branch. How should I write Based-on: for patchew 
in this case?

-- 
Best regards,
Vladimir
