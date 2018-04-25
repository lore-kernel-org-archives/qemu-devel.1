Received: from eggs.gnu.org ([2001:4830:134:3::10]:38687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBTLz-0004Hl-Fl
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 18:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBTLy-0005lw-Ge
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 18:57:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fBTLy-0005lj-Bd
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 18:57:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8A97406C745
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 22:57:33 +0000 (UTC)
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-4-lersek@redhat.com>
	<5f76e0aa-389f-82b8-9bac-8405f51b8d2c@redhat.com>
	<20180425125446.GJ30024@redhat.com>
	<c2145dbd-5cbf-13df-76fe-68b86cde488e@redhat.com>
	<a6e96ed4-ab0d-10db-69c9-324fbdad94d5@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <949e1929-331e-7606-7b28-8301d47c7cd6@redhat.com>
Date: Thu, 26 Apr 2018 00:57:29 +0200
MIME-Version: 1.0
In-Reply-To: <a6e96ed4-ab0d-10db-69c9-324fbdad94d5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] qapi: add SysEmuTarget to "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <dgibson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 04/25/18 21:08, Eric Blake wrote:
> On 04/25/2018 02:05 PM, Laszlo Ersek wrote:
> 
>>>>> +             'x86_64', 'xtensa', 'xtensaeb' ] }
>>>>
>>>> x86_64 doesn't match our typical conventions of preferring '-' over '_';
>>>> also, wikipedia mentions both spellings but under the page name
>>>> 'x86-64'.  Is it worth switching that enum constant?
>>>>
>>>> https://en.wikipedia.org/wiki/X86-64
>>>
>>> I would not want that - SysEmuTarget is supposed to be correlated with
>>> the qemu-system-$TARGET  binary names and we use qemu-system-x86_64
>>> there.
>>
>> Right; also TARGET_NAME is looked up as follows in patch #4, in
>> qmp_query_target():
>>
>> +    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, -1,
>> +                                 &error_abort);
>>
>> That would fail if we used "x86-64" here.
> 
> Then worth a mention in the commit message to make it obvious that our
> choice of _ for over-the-wire QMP is intentional.
> 

Right; I'll add a note to the schema too.

Thanks!
Laszlo
