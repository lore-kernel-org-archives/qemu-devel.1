Received: from eggs.gnu.org ([2001:4830:134:3::10]:59778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtUn-00063A-Pg
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtUk-0007CP-NV
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:48:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehtUk-0007BO-HU
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:48:22 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-3-armbru@redhat.com>
	<05113113-5b7c-c094-2870-2eb4a5b09454@redhat.com>
Date: Sat, 03 Feb 2018 09:48:16 +0100
In-Reply-To: <05113113-5b7c-c094-2870-2eb4a5b09454@redhat.com> (Eric Blake's
	message of "Fri, 2 Feb 2018 09:47:21 -0600")
Message-ID: <871si25ui7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 02/21] qapi: Generate up-to-date
 copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/02/2018 07:03 AM, Markus Armbruster wrote:
>> Each generator carries a copyright notice for the generator itself,
>> and another one for the files it generates.  Only the former have been
>> updated along the way, the latter have not, and are all out of date.
>> 
>> Fix by copying the generator's copyright notice to the generated files
>> instead.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/scripts/qapi-commands.py
>> @@ -1,16 +1,17 @@
>> -#
>> -# QAPI command marshaller generator
>> -#
>> -# Copyright IBM, Corp. 2011
>> -# Copyright (C) 2014-2016 Red Hat, Inc.
>> -#
>> -# Authors:
>> -#  Anthony Liguori <aliguori@us.ibm.com>
>> -#  Michael Roth    <mdroth@linux.vnet.ibm.com>
>> -#  Markus Armbruster <armbru@redhat.com>
>> -#
>> -# This work is licensed under the terms of the GNU GPL, version 2.
>> -# See the COPYING file in the top-level directory.
>> +"""
>> +QAPI command marshaller generator
>> +
>> +Copyright IBM, Corp. 2011
>> +Copyright (C) 2014-2018 Red Hat, Inc.
>> +
>> +Authors:
>> + Anthony Liguori <aliguori@us.ibm.com>
>> + Michael Roth <mdroth@linux.vnet.ibm.com>
>> + Markus Armbruster <armbru@redhat.com>
>> +
>> +This work is licensed under the terms of the GNU GPL, version 2.
>> +See the COPYING file in the top-level directory.
>> +"""
>
> So python lets you start a file with a string constant that is not
> associated with any variable name?

It's the module's doc string, done the same way as function doc strings.

https://www.python.org/dev/peps/pep-0257/#what-is-a-docstring

>>  (fdef, fdecl) = open_output(output_dir, do_c, do_h, prefix,
>>                              'qmp-marshal.c', 'qmp-commands.h',
>> -                            blurb)
>> +                            blurb, __doc__)
>
> Ah, and there's what I was missing - python auto-assigns such an initial
> string to a magic automatic variable.  Cool language feature I hadn't
> seen before!
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
