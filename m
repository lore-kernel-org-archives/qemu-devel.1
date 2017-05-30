Received: from eggs.gnu.org ([2001:4830:134:3::10]:45356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFheL-000447-Jz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFheG-0006fn-Mj
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:57:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dFheG-0006fa-HS
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:57:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 789FB4AE99
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:57:23 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-10-git-send-email-vyasevic@redhat.com>
	<87y3tefy0z.fsf@secure.mitica>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <30d8f4bf-b5e1-4ec1-38b4-752280e4bb14@redhat.com>
Date: Tue, 30 May 2017 09:57:09 -0400
MIME-Version: 1.0
In-Reply-To: <87y3tefy0z.fsf@secure.mitica>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/12] hmp: add announce paraters info/set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

On 05/30/2017 06:18 AM, Juan Quintela wrote:
> Vladislav Yasevich <vyasevic@redhat.com> wrote:
>> Add HMP command to control and read annoucment parameters.
>>
>> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> 
>> + cleanup:
>> +    if (err) {
>> +        error_report_err(err);
>> +    }
>> +}
> 
> 
> My understanding is that this the "cool way" to spell this nowadays is:
> 
> hmp_handle_error(mon, &err);
> 
> Just in case you want to change it.
> 

Thanks. I must have used an older function as base.  I'll check it out.

-vlad
