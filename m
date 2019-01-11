Received: from eggs.gnu.org ([209.51.188.92]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ghvg3-0008F3-LE
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ghvg1-0003uj-VO
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:12:43 -0500
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:48068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ghvg1-0003m5-E9
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:12:41 -0500
Received: from player756.ha.ovh.net (unknown [10.109.143.72])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 9FFB514E02D
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 13:12:36 +0100 (CET)
References: <1547196148-12250-1-git-send-email-thuth@redhat.com>
	<b1db55de-6741-76c7-33b1-74fc2692b82c@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <694664dc-1bb7-0bb8-f44b-23b3175fea09@kaod.org>
Date: Fri, 11 Jan 2019 13:12:23 +0100
MIME-Version: 1.0
In-Reply-To: <b1db55de-6741-76c7-33b1-74fc2692b82c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] HACKING: Clarify the paragraph about
 typedefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 1/11/19 11:38 AM, Paolo Bonzini wrote:
> On 11/01/19 09:42, Thomas Huth wrote:
>>  2.3. Typedefs
>> -Typedefs are used to eliminate the redundant 'struct' keyword.
>> +Typedefs can be used to eliminate the redundant 'struct' keyword. This is
>> +especially helpful for common types that are used all over the place. Since
>> +certain C compilers choke on duplicated typedefs, you should avoid them and
>> +declare a typedef only in one header file. For common types, you can use
>> +"include/qemu/typedefs.h" for example. Note that it is also perfectly fine to
>> +use forward struct definitions without typedefs for references in headers
>> +to avoid the problem with duplicated typedefs.
>>  
> 
> I agree 100% with the wording after "Since".  However, I think the first
> part should be made stronger, not weaker.
> 
> Typedefs are use to eliminate the redundant 'struct' keyword, since type
> names have a different style than other identifiers ("CamelCase" versus
> "snake_case").  Each struct should have a CamelCase name and a
> corresponding typedef.
> 
> Since certain C compilers choke on duplicated typedefs, you should avoid
> them and declare a typedef only in one header file.  For common types,
> you can use "include/qemu/typedefs.h" for example.  However, as a metter
> of convenience it is also perfectly fine to use forward struct
> definitions instead of typedefs in headers and function prototypes; this
> avoids problems with duplicated typedefs and reduces the need to include
> headers from other headers.

I suppose this is difficult to check with checkpatch ? It's easy to
cross the border as I have proven many times. 
 
> And, I would move it to CODING_STYLE since we are at it. :)

yes.

C.
