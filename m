Received: from eggs.gnu.org ([2001:4830:134:3::10]:51823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsawF-0007cm-Ep
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 17:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsawE-0006xm-Mc
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 17:45:15 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-4-jsnow@redhat.com>
	<7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
	<bd4dc120-2fb2-fc4d-c11f-d79631eb7c16@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d6c3b676-2fa2-f4e3-439a-93785827579f@redhat.com>
Date: Wed, 22 Aug 2018 17:45:01 -0400
MIME-Version: 1.0
In-Reply-To: <bd4dc120-2fb2-fc4d-c11f-d79631eb7c16@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com



On 08/22/2018 07:52 AM, Max Reitz wrote:
> On 2018-08-22 13:43, Max Reitz wrote:
> 
> [...]
> 
>> I'd like .main_loop_settle().  Or .main_loop_post_run().  I think it's
>> OK to have names that aren't as cool and tense as possible, when in
>> return they actually tell you what they're doing.  (Sure,
>> .main_loop_post_run() sounds really stupid, but it tells you exactly
>> when the function is called and what it's for.)
> 
> Looking at the next patch, I realized that .main_loop_complete() or
> .complete_in_main_loop() would work just as well.  (No, I don't see any
> confusion with whether you need to call job_completed(), especially
> since after this series you can probably make that function static to
> job.c.)
> 
> Max
> 

I'm sorry to announce that after the part two of this series, the
callback will be erased completely, so the name is maybe less... important.
