Received: from eggs.gnu.org ([2001:4830:134:3::10]:42272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eo7w0-0007ZF-Ao
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eo7vx-0006K1-34
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:26:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eo7vw-0006JX-UR
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:26:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 106E7407A9AA
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:26:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <040b3661-52e8-bf66-3751-58e443d03e4d@redhat.com> (Thomas Huth's
	message of "Tue, 20 Feb 2018 12:56:49 +0100")
References: <20180212160340.15333-1-dgilbert@redhat.com>
	<20180212160340.15333-3-dgilbert@redhat.com>
	<040b3661-52e8-bf66-3751-58e443d03e4d@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 20 Feb 2018 14:26:26 +0100
Message-ID: <874lmbx059.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] tests/migration: Add test for
 migration to bad destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, peterx@redhat.com

Thomas Huth <thuth@redhat.com> wrote:
> On 12.02.2018 17:03, Dr. David Alan Gilbert (git) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> 
>> Check the source survives.
>> 
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>  tests/migration-test.c | 65 ++++++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 50 insertions(+), 15 deletions(-)
> [...]
>> @@ -615,6 +649,7 @@ int main(int argc, char **argv)
>>  
>>      qtest_add_func("/migration/postcopy/unix", test_migrate);
>>      qtest_add_func("/migration/deprecated", test_deprecated);
>> +    qtest_add_func("/migration/bad_dest", test_baddest);
>
> While running "make check", I now see some "Failed to connect socket:
> Connection refused" messages popping up, which is a little bit
> confusing. Would it be possible to silence these messages somehow?


I will take a look at that.  I haven't looked where they came from.
Thanks.

Later, Juan.
