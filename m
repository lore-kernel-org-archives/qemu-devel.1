Received: from eggs.gnu.org ([2001:4830:134:3::10]:53043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0UKx-0001dT-Ck
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 12:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0UKu-00024z-0M
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 12:19:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1g0UKt-00024B-Op
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 12:19:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95BE5C049D5C
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 16:19:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <fb0a524f-81d0-cfdf-81d2-887c89272805@redhat.com> (Thomas Huth's
	message of "Thu, 13 Sep 2018 17:03:37 +0200")
References: <20180913125343.10912-1-quintela@redhat.com>
	<20180913125343.10912-13-quintela@redhat.com>
	<fb0a524f-81d0-cfdf-81d2-887c89272805@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 13 Sep 2018 18:19:07 +0200
Message-ID: <87y3c5pdz8.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 12/12] tests/migration: Enable the migration
 test on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Thomas Huth <thuth@redhat.com> wrote:
> On 2018-09-13 14:53, Juan Quintela wrote:
>> From: Thomas Huth <thuth@redhat.com>
>> 
>> We can re-use the s390-ccw bios code to implement a small firmware
>> for a s390x guest which prints out the "A" and "B" characters and
>> modifies the memory, as required for the migration test.
>> 
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Message-Id: <1535027120-26187-1-git-send-email-thuth@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 

>> +a-b-bios.h: s390x.elf
>> +	echo "$$__note" > header.tmp
>> +	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
>> +	mv header.tmp $@
>> +
>> +s390x.elf: a-b-bios.c
>> +	$(CROSS_PREFIX)gcc $(CFLAGS) -I$(fwdir) $(fwdir)/start.S \
>> +            $(fwdir)/sclp.c -o $@ $<
>
> Your modifications look basically fine to me, but please also strip the
> binary after compiling it, so that the header will be quite a bit smaller.

Oops, had it on the s390 and forgot to include it:

      $(CROSS_PREFIX)strip --strip-unneded $@

Now sizes are similar.

Thanks, Juan.
