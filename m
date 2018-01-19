Received: from eggs.gnu.org ([2001:4830:134:3::10]:48627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecVY9-0006e3-GO
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecVY4-00065y-J4
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:13:37 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:46760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecVY4-00065E-Ec
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:13:32 -0500
Received: by mail-qt0-x243.google.com with SMTP id o35so3209461qtj.13
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 04:13:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <5A61B1CB02000078001A0368@prv-mh.provo.novell.com>
	<20180119092808.GC16798@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2454f067-178a-f717-c625-68a01a403c3e@amsat.org>
Date: Fri, 19 Jan 2018 09:13:28 -0300
MIME-Version: 1.0
In-Reply-To: <20180119092808.GC16798@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] allow to build with older sed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Jan Beulich <JBeulich@suse.com>
Cc: qemu-devel@nongnu.org

On 01/19/2018 06:28 AM, Daniel P. Berrange wrote:
> On Fri, Jan 19, 2018 at 12:52:27AM -0700, Jan Beulich wrote:
>> sed's -E option may not be supported by older distros. As there's no
>> point using sed here at all, use just shell mechanisms to establish the
>> variable values, starting from the stem instead of the full target.
>>
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> 
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -242,8 +242,7 @@ GENERATED_FILES += $(KEYCODEMAP_FILES)
>>  
>>  ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
>>  	$(call quiet-command,\
>> -	    src=$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$$,\1,") && \
>> -	    dst=$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$$,\2,") && \
>> +	    stem=$* && src=$${stem%-to-*} dst=$${stem#*-to-} && \
>>  	    test -e $(KEYCODEMAP_GEN) && \
>>  	    $(PYTHON) $(KEYCODEMAP_GEN) \
>>  	          --lang glib2 \
> 
> Clever ! I was hoping someone might suggest a cleaner approach one day
> 
> Regards,
> Daniel
> 
