Received: from eggs.gnu.org ([2001:4830:134:3::10]:39227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eSKZP-0003ar-NE
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eSKZK-0005gB-RV
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:28:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eSKZK-0005fc-L8
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:28:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D942C859FA
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 10:28:45 +0000 (UTC)
References: <20171205151553.7834-1-famz@redhat.com>
	<20171220095104.GB10812@lemon>
	<af9ceced-6a51-1fef-916b-69602403c2a4@redhat.com>
	<20171222015412.GC7652@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21f15557-9d1c-8140-2239-4366d3e62899@redhat.com>
Date: Fri, 22 Dec 2017 11:28:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171222015412.GC7652@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Add share-rw option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On 22/12/2017 02:54, Fam Zheng wrote:
> On Wed, 12/20 11:06, Paolo Bonzini wrote:
>> On 20/12/2017 10:51, Fam Zheng wrote:
>>> On Tue, 12/05 23:15, Fam Zheng wrote:
>>>> Add the property to the device model, then parse it by calling
>>>> blkconf_apply_backend_options().
>>>>
>>>> In addition to blk_set_perm(), the called function also handles error
>>>> options and wce. For error options we've already checked that the
>>>> default values are used, for wce we don't have the option either so it
>>>> is always the default (true). In other words there is no change of
>>>> behavior in these regards.
>>>>
>>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>>
>>> Ping? :)
>>
>> Already queued.
>>
> 
> But I think it was not in yesterday's PULL?

I confused it with the scsi-block one.

Paolo
