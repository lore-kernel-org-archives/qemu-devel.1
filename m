Received: from eggs.gnu.org ([2001:4830:134:3::10]:54828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bauerman@linux.vnet.ibm.com>) id 1dqUWD-0002cU-Tk
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 21:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bauerman@linux.vnet.ibm.com>) id 1dqUWA-000607-L8
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 21:25:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60606
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bauerman@linux.vnet.ibm.com>)
	id 1dqUWA-0005xv-Fr
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 21:25:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v891NlZW117605
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 21:25:05 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cv16wjuha-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 21:25:04 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bauerman@linux.vnet.ibm.com>;
	Fri, 8 Sep 2017 21:25:04 -0400
References: <20170818174614.10930-1-bauerman@linux.vnet.ibm.com>
	<87r2vl37kb.fsf@dusky.pond.sub.org>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
In-reply-to: <87r2vl37kb.fsf@dusky.pond.sub.org>
Date: Fri, 08 Sep 2017 22:24:58 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <877ex8ack5.fsf@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .dir-locals.el: Explicitly set indentation
 level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


Markus Armbruster <armbru@redhat.com> writes:

> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>
>> At least in some configurations, setting c-file-style is not enough to
>> conform to the QEMU coding style, so explicitly set c-basic-offset as =
well.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>> ---
>>
>> My emacs was using indentation level of 8 spaces and this patch convin=
ced
>> it to use the correct value.
>>
>> I set c-basic-offset set to tab-width in my ~/.spacemacs which perhaps
>> isn't the wisest thing to do, but since there's a .dir-locals.el we ca=
n
>> make the editor always do the right thing.
>
> I think some of this rationale should be worked into the commit message
> if we decide the patch makes sense.

Ok, I will send a v2 with the rationale in the commit message if it's
determined that the patch itself is ok.

>>  .dir-locals.el | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/.dir-locals.el b/.dir-locals.el
>> index 3ac0cfc6f0d6..8e47418c5996 100644
>> --- a/.dir-locals.el
>> +++ b/.dir-locals.el
>> @@ -1,2 +1,3 @@
>>  ((c-mode . ((c-file-style . "stroustrup")
>> -	    (indent-tabs-mode . nil))))
>> +	    (indent-tabs-mode . nil)
>> +	    (c-basic-offset . 4))))
>
> Style "stroustrup" already specified c-basic-offset 4.  If we need to
> specify this setting a second time, why don't we need to specify the
> style's other settings a second time, too?

I added (defvaralias 'c-basic-offset 'tab-width) to my configuration
file following a suggestion from the "Indentation Basics" page of
EmacsWiki=C2=B9, which is the first hit if you search for "emacs indentat=
ion
width".

Because of that, I assume a lot of people will have that option in their
configuration file. If there are other settings that are common and also
interfere with the stroustrup style I think it makes sense to include
them in .dir-locals.el as well.

--=20
Thiago Jung Bauermann
IBM Linux Technology Center


=C2=B9 https://www.emacswiki.org/emacs/IndentationBasics
