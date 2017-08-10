Received: from eggs.gnu.org ([2001:4830:134:3::10]:55790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfqJb-00036k-HZ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfqJY-0001f9-Eg
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:28:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfqJY-0001eN-8K
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:28:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502367921-17730-1-git-send-email-armbru@redhat.com>
	<1502367921-17730-2-git-send-email-armbru@redhat.com>
	<1837a5c7-92a2-a40a-5f96-21bd448790bd@redhat.com>
Date: Thu, 10 Aug 2017 18:28:00 +0200
In-Reply-To: <1837a5c7-92a2-a40a-5f96-21bd448790bd@redhat.com> (Eric Blake's
	message of "Thu, 10 Aug 2017 09:43:46 -0500")
Message-ID: <87o9rn8k1b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Factor object_create() out of
 main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, el13635@mail.ntua.gr

Eric Blake <eblake@redhat.com> writes:

> On 08/10/2017 07:25 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  vl.c | 21 ++++++++++-----------
>>  1 file changed, 10 insertions(+), 11 deletions(-)
>> 
>
>> +++ b/vl.c
>> @@ -2845,7 +2845,6 @@ static bool object_create_initial(const char *type)
>>      return true;
>>  }
>>  
>> -
>>  /*
>
> Spurious whitespace change? I can live with it because it adds
> consistency, but it's not on a function directly touched by this patch.

Not intentional (alternatively: I've since forgotten).  I'll drop it.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
