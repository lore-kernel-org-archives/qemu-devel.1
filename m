Received: from eggs.gnu.org ([2001:4830:134:3::10]:51950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1df0gc-0006Fb-4Z
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1df0gY-0003sS-2Y
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:20:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1df0gX-0003s7-Pq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:20:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <150107094952.114.932926322923994155@5d477a5b5989>
	<e982b2c6-dab4-24a0-7db4-2e76c370d227@redhat.com>
Date: Tue, 08 Aug 2017 11:20:13 +0200
In-Reply-To: <e982b2c6-dab4-24a0-7db4-2e76c370d227@redhat.com> (Eric Blake's
	message of "Wed, 26 Jul 2017 07:22:20 -0500")
Message-ID: <87fud24drm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, no-reply@patchew.org, kraxel@redhat.com, famz@redhat.com

Just back from the signed-vs-unsigned swamp, still catching up, sorry
for the delay...

Eric Blake <eblake@redhat.com> writes:

> On 07/26/2017 07:09 AM, no-reply@patchew.org wrote:
>> Hi,
>> 
>> This series failed build test on s390x host. Please find the details below.
>> 
>> Message-id: 20170726115637.21558-1-kraxel@redhat.com
>> Subject: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
>> Type: series
>> 
>
>>   GEN     docs/interop/qemu-ga-qapi.texi
>>   GEN     qga/qapi-generated/qga-qapi-visit.h
>>   GEN     qga/qapi-generated/qga-qmp-commands.h
>>   GEN     qga/qapi-generated/qga-qapi-types.h
>>   GEN     qga/qapi-generated/qga-qapi-types.c
>>   GEN     qga/qapi-generated/qga-qapi-visit.c
>>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>> Traceback (most recent call last):
>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py", line 300, in <module>
>>     main(sys.argv)
>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py", line 296, in main
>>     print texi_schema(schema)
>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py", line 279, in texi_schema
>>     gen.symbol(doc, schema.lookup_entity(doc.symbol))
>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py", line 263, in symbol
>>     entity.visit(self)
>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi.py", line 1137, in visit
>>     self.member_names(), self.prefix)
>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py", line 218, in visit_enum_type
>>     member_func=texi_enum_value))
>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py", line 200, in texi_entity
>>     + texi_sections(doc))
>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py", line 160, in texi_members
>>     items += member_func(section.member) + desc + '\n'
>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py", line 133, in texi_enum_value
>>     return '@item @code{%s}\n' % value.name
>> AttributeError: 'NoneType' object has no attribute 'name'
>
> Eww, we have a bug in our qapi generator (a stack dump instead of a nice
> error message).  I suspect this is caused by your use of '@ac_*' instead
> of spelling out all the ac_ members added in qapi-schema.json in 4/5 -

Yes, we require doc comments to match the schema.  Wildcards aren't
supported.  They could be, if we want them badly enough.

> but it IS something that needs to be fixed on your end to quit tripping
> up the doc generator.

Has anyone worked on a fix for qapi2texi.py?
