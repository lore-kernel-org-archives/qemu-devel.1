Received: from eggs.gnu.org ([2001:4830:134:3::10]:45967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHVb-0000Sk-Jx
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHVX-0003h5-N9
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:51:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40312 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epHVX-0003fM-Il
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:51:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-28-armbru@redhat.com>
	<f96c450c-9d20-c976-aa4e-6c6438788adb@redhat.com>
Date: Fri, 23 Feb 2018 18:51:41 +0100
In-Reply-To: <f96c450c-9d20-c976-aa4e-6c6438788adb@redhat.com> (Eric Blake's
	message of "Mon, 12 Feb 2018 16:36:38 -0600")
Message-ID: <87zi3ziogi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 27/29] qapi: Move qapi-schema.json to
 qapi/, rename generated files
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

> On 02/11/2018 03:36 AM, Markus Armbruster wrote:
>> Move qapi-schema.json to qapi/, so it's next to its modules, and all
>> files get generated to qapi/, not just the ones generated for modules.
>>
>> Consistently name the generated files qapi-MODULE.EXT:
>> qmp-commands.[ch] become qapi-commands.[ch], qapi-event.[ch] become
>> qapi-events.[ch], and qmp-introspect.[ch] become qapi-introspect.[ch].
>> This gets rid of the temporary hacks in scripts/qapi/commands.py and
>> scripts/qapi/events.py.
>
> Ah, so my parallel series that proposed naming the file
> qapi/qmp-schema.qapi gets interesting, with your patch favoring the
> qapi- naming everywhere.  I'll have to think about how much (or
> little) of my series to rebase on top of this (I like my notion of
> renaming to the .qapi suffix, though, as we really are using files
> that aren't JSON, but only resemble it).
>
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/.gitignore
>> @@ -29,8 +29,8 @@
>>   /qga/qapi-generated
>>   /qapi-generated
>>   /qapi-gen-timestamp
>> -/qapi-builtin-types.[ch]
>> -/qapi-builtin-visit.[ch]
>> +/qapi/qapi-builtin-types.[ch]
>> +/qapi/qapi-builtin-visit.[ch]
>
> Might be some interesting churn if you like my idea of using globs for
> easier maintenance of this file.
>
>> +++ b/tpm.c
>> @@ -182,7 +182,6 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
>>     /*
>>    * Walk the list of active TPM backends and collect information about them
>> - * following the schema description in qapi-schema.json.
>>    */
>
> Should the overall comment keep the trailing '.'?

I'm fine either way.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
