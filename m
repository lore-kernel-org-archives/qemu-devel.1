Received: from eggs.gnu.org ([2001:4830:134:3::10]:52019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXUJ9-0004Xs-Ci
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXUJ8-00078C-IU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:21:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-4-git-send-email-armbru@redhat.com>
	<e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
Date: Tue, 18 Jul 2017 17:20:59 +0200
In-Reply-To: <e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com> (Eric Blake's
	message of "Tue, 18 Jul 2017 09:53:25 -0500")
Message-ID: <87379tsrdw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first
 class 'null' type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/18/2017 08:41 AM, Markus Armbruster wrote:
>> I expect the 'null' type to be useful mostly for members of alternate
>> types.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/include/qapi/qmp/qobject.h
>> @@ -93,9 +93,9 @@ static inline QType qobject_type(const QObject *obj)
>>      return obj->type;
>>  }
>>  
>> -typedef struct QNull {
>> +struct QNull {
>
> This line was just added...
>
>>      QObject base;
>> -} QNull;
>> +};
>>  
>>  extern QNull qnull_;
>>  
>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>> index 2706aab..ba69bd8 100644
>> --- a/include/qemu/typedefs.h
>> +++ b/include/qemu/typedefs.h
>> @@ -87,6 +87,7 @@ typedef struct QEMUSGList QEMUSGList;
>>  typedef struct QEMUTimer QEMUTimer;
>>  typedef struct QEMUTimerListGroup QEMUTimerListGroup;
>>  typedef struct QObject QObject;
>> +typedef struct QNull QNull;
>
> ...is it worth hoisting this typedef into 2/10 for less churn?

Less code churn, but more commit message explaining, unless we simply
sneak it into typedefs.h without justification.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
