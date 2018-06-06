Received: from eggs.gnu.org ([2001:4830:134:3::10]:43770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQeEM-0002jW-EQ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQeEH-0007HJ-HU
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:36:26 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:46689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQeEH-0007H5-BN
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:36:21 -0400
Received: by mail-vk0-x244.google.com with SMTP id b134-v6so4502540vke.13
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 12:36:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530200334.24179-1-f4bug@amsat.org>
	<22ca41bb-9f8b-e8bb-e676-b5c96f3f9add@redhat.com>
	<acf7522a-4fc0-5138-9797-6cfcc5ad5719@amsat.org>
	<20180606192429.GV7451@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2bdd428e-8790-7c1f-f324-4bc6b6923c15@amsat.org>
Date: Wed, 6 Jun 2018 16:36:16 -0300
MIME-Version: 1.0
In-Reply-To: <20180606192429.GV7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] configure: Enable out-of-tree
 acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>, qemu-devel@nongnu.org

On 06/06/2018 04:24 PM, Eduardo Habkost wrote:
> On Tue, Jun 05, 2018 at 11:45:03AM -0300, Philippe Mathieu-Daudé wrote:
> [... something about config files ...]
>>> And after that, the following would run all "console" tests:
>>>
>>>   avocado run -t console
>>>
>>> How does this sound?
>>
>> For my use cases this doesn't worry me, I'll let Eduardo/Fam opine about
>> use_test_dir_when_no_references_given.
> 
> Well, I can't give an opinion because I couldn't understand
> what's the final goal here.

You cut too much, the relevant part is:

  On 05/30/2018 10:06 PM, Cleber Rosa wrote:
  > But at the same, there are security implications: `list` won't
  > load/execute any test code (different from, say, standard Python
  > unittests), while "run" obviously will.  So "avocado run" may end up
  > running what users don't want if a malicious user controls
  > "$avocado_datadir_paths_test_dir".

> 
> What exactly is missing in the current solution?  Why
> "avocado run -t console ." wouldn't work?

It doesn't work in out-of-tree builds, I have to use the full path:

  >>   build_dir$ avocado run
/full/path/to/sources/qemu/tests/acceptance/boot_linux_console.py

Don't worry about this RFC patch, I don't have problem to use the full
path for now, I suppose the Avocado team will resolve this differently
via a configurable option.

Regards,

Phil.
