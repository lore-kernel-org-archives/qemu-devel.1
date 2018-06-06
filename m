Received: from eggs.gnu.org ([2001:4830:134:3::10]:55667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fQeyC-0008VW-9Z
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fQey9-0001TJ-5k
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:23:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fQey9-0001SW-0P
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:23:45 -0400
References: <20180530200334.24179-1-f4bug@amsat.org>
	<22ca41bb-9f8b-e8bb-e676-b5c96f3f9add@redhat.com>
	<acf7522a-4fc0-5138-9797-6cfcc5ad5719@amsat.org>
	<20180606192429.GV7451@localhost.localdomain>
	<2bdd428e-8790-7c1f-f324-4bc6b6923c15@amsat.org>
	<20180606201140.GZ7451@localhost.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <34060c1c-ca8d-8aed-7f62-609d82e734b7@redhat.com>
Date: Wed, 6 Jun 2018 16:23:42 -0400
MIME-Version: 1.0
In-Reply-To: <20180606201140.GZ7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Amador Pahim <amador@pahim.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org



On 06/06/2018 04:11 PM, Eduardo Habkost wrote:
> On Wed, Jun 06, 2018 at 04:36:16PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> On 06/06/2018 04:24 PM, Eduardo Habkost wrote:
>>> On Tue, Jun 05, 2018 at 11:45:03AM -0300, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>> [... something about config files ...]
>>>>> And after that, the following would run all "console" tests:
>>>>>
>>>>>   avocado run -t console
>>>>>
>>>>> How does this sound?
>>>>
>>>> For my use cases this doesn't worry me, I'll let Eduardo/Fam opine a=
bout
>>>> use_test_dir_when_no_references_given.
>>>
>>> Well, I can't give an opinion because I couldn't understand
>>> what's the final goal here.
>>
>> You cut too much, the relevant part is:
>>
>>   On 05/30/2018 10:06 PM, Cleber Rosa wrote:
>>   > But at the same, there are security implications: `list` won't
>>   > load/execute any test code (different from, say, standard Python
>>   > unittests), while "run" obviously will.  So "avocado run" may end =
up
>>   > running what users don't want if a malicious user controls
>>   > "$avocado_datadir_paths_test_dir".
>=20
> The final goal still isn't clear to me.  Why would somebody want
> to use $avocado_datadir_paths_test_dir instead of just specifying
> "." in the command-line?
>=20
>=20
>>
>>>
>>> What exactly is missing in the current solution?  Why
>>> "avocado run -t console ." wouldn't work?
>>
>> It doesn't work in out-of-tree builds, I have to use the full path:
>>
>>   >>   build_dir$ avocado run
>> /full/path/to/sources/qemu/tests/acceptance/boot_linux_console.py
>=20
> Isn't the symlink you suggested a better solution than requiring
> the user to edit a config file?
>=20

It's definitely the simplest, and would avoid a questionable knob and
behavior in Avocado.

- Cleber.
