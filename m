Received: from eggs.gnu.org ([2001:4830:134:3::10]:42309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1erqzU-0001ft-7C
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1erqzP-0000MZ-TW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:09:16 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1erqzP-0000M3-Mu
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:09:11 -0500
Received: by mail-oi0-x241.google.com with SMTP id t185so7903003oif.6
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 12:09:11 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <1520004397-28521-1-git-send-email-minyard@acm.org>
	<20180302200202.GF3154@work-vm>
From: Corey Minyard <minyard@acm.org>
Message-ID: <6cf83dfb-9dcb-2cc7-0b53-1b574977d122@acm.org>
Date: Fri, 2 Mar 2018 14:09:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180302200202.GF3154@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 0/2] ipmi: Fix vmstate transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 03/02/2018 02:02 PM, Dr. David Alan Gilbert wrote:
> * minyard@acm.org (minyard@acm.org) wrote:
>> I apologize for the resend, I left the list off the previous post.
>>
>> This is unchanged since the previous post, two weeks ago.  I received
>> no comments, so I guess it's ok.  It's fairly broken now, so I would
>> like this fixed.
> Sorry, I'll look at it on Monday; I was out last week and hadn't got
> around to this set.

Thanks a bunch.  I have some doubt about how I handled the backwards
compatibility in the KCS code.  It works, but I'm not sure it's right.

-corey

> Dave
>
>> Changes from v1:
>>    * Validate the data values in pre_load functions.
>>    * For KCS, instead of an old function, create a separate vmstate
>>      structure for the new version.  The name on the old vmstate
>>      structure wasn't specific enough, so a new name was needed,
>>      The old structure is set up to never be sent, but it can be
>>      received.
>>
>> The following changes since commit 427cbc7e4136a061628cb4315cc8182ea36d772f:
>>
>>    Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-03-01 18:46:41 +0000)
>>
>> are available in the git repository at:
>>
>>    https://github.com/cminyard/qemu.git tags/ipmi-vmstate-fixes
>>
>> for you to fetch changes up to 90797371d9a3138657e7b1f7ab4425eb67d6fd0a:
>>
>>    ipmi: Use proper struct reference for BT vmstate (2018-03-02 07:48:39 -0600)
>>
>> ----------------------------------------------------------------
>> Fix the IPMI vmstate code to work correctly in all cases.  Heavily
>> tested under load.
>>
>> ----------------------------------------------------------------
>> Corey Minyard (2):
>>        ipmi: Use proper struct reference for KCS vmstate
>>        ipmi: Use proper struct reference for BT vmstate
>>
>>   hw/ipmi/isa_ipmi_bt.c  | 61 ++++++++++++++++++++++++++++++---------
>>   hw/ipmi/isa_ipmi_kcs.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 123 insertions(+), 15 deletions(-)
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
