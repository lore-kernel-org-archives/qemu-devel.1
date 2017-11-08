Received: from eggs.gnu.org ([2001:4830:134:3::10]:46640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCT6m-0007fh-G0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCT6h-0000j0-IV
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:21:44 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:54190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCT6h-0000iq-Do
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:21:39 -0500
Received: by mail-qt0-x242.google.com with SMTP id n61so3985290qte.10
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 08:21:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171030040056.11780-1-f4bug@amsat.org>
	<20171030082029.GY2993@localhost.localdomain>
	<20171108132857.GT12670@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1ecb6a4b-465f-0949-e039-441038f1adf8@amsat.org>
Date: Wed, 8 Nov 2017 13:21:33 -0300
MIME-Version: 1.0
In-Reply-To: <20171108132857.GT12670@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] vl: only display available accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 11/08/2017 10:28 AM, Daniel P. Berrange wrote:
> On Mon, Oct 30, 2017 at 09:20:29AM +0100, Eduardo Habkost wrote:
>> On Mon, Oct 30, 2017 at 01:00:56AM -0300, Philippe Mathieu-Daudé wrote:
>>> examples configuring with '--enable-kvm --disable-tcg'
>>>
>>> - before
>>>
>>>   $ qemu-system-x86_64 -accel help
>>>   Possible accelerators: kvm, xen, hax, tcg
>>>
>>>   $ qemu-system-x86_64 -accel tcg
>>>   qemu-system-x86_64: -machine accel=tcg: No accelerator found
>>>
>>>   # qemu-system-x86_64 -accel hax
>>>   qemu-system-x86_64: -machine accel=hax: No accelerator found
>>>
>>>   # qemu-system-x86_64 -accel xen
>>>   xencall: error: Could not obtain handle on privileged command interface: No such file or directory
>>>   xen be core: xen be core: can't open xen interface
>>>   can't open xen interface
>>>   qemu-system-x86_64: failed to initialize Xen: Operation not permitted
>>>
>>> - after
>>>
>>>   $ qemu-system-x86_64 -accel help
>>>   Possible accelerators: kvm
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>> RFC because:
>>>     - I don't think this is the nicest way, too much #ifdef'fery in main()
>>
>> I suggest using object_class_get_list(TYPE_ACCEL, false).
> 
> And check the result of the available() method on the returned classes
> too, to filter the results.

Good idea! I'll use that.
