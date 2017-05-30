Received: from eggs.gnu.org ([2001:4830:134:3::10]:41502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFhTb-0003It-Qi
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFhTY-0003KY-2e
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:46:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dFhTX-0003KK-So
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:46:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E27B986647
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:46:18 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-4-git-send-email-vyasevic@redhat.com>
	<87d1aqhcy5.fsf@secure.mitica>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <b77c525b-8110-9d31-fcb6-fad6b94bb4ee@redhat.com>
Date: Tue, 30 May 2017 09:46:10 -0400
MIME-Version: 1.0
In-Reply-To: <87d1aqhcy5.fsf@secure.mitica>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/12] migration: Switch to using
 announcement timer
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

On 05/30/2017 06:10 AM, Juan Quintela wrote:
> Vladislav Yasevich <vyasevic@redhat.com> wrote:
>> Switch qemu_announce_self and virtio annoucements to use
>> the announcement timer framework.  This makes sure that both
>> timers use the same timeouts and number of annoucement attempts
>>
>> Based on work by Dr. David Alan Gilbert <dgilbert@redhat.com>
>>
>> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> 
>>  static void qemu_announce_self_once(void *opaque)
>>  {
>> -    static int count = SELF_ANNOUNCE_ROUNDS;
>> -    QEMUTimer *timer = *(QEMUTimer **)opaque;
>> +    AnnounceTimer *timer = (AnnounceTimer *)opaque;
> 
> Cast from void * is never needed.
> 

OK

Thanks
-vlad
