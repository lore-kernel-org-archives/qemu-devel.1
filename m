Received: from eggs.gnu.org ([2001:4830:134:3::10]:52870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQemb-0001jR-CD
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQemY-0002Rv-7v
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQemY-0002RJ-0z
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:11:46 -0400
Date: Wed, 6 Jun 2018 17:11:40 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180606201140.GZ7451@localhost.localdomain>
References: <20180530200334.24179-1-f4bug@amsat.org>
	<22ca41bb-9f8b-e8bb-e676-b5c96f3f9add@redhat.com>
	<acf7522a-4fc0-5138-9797-6cfcc5ad5719@amsat.org>
	<20180606192429.GV7451@localhost.localdomain>
	<2bdd428e-8790-7c1f-f324-4bc6b6923c15@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2bdd428e-8790-7c1f-f324-4bc6b6923c15@amsat.org>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>, qemu-devel@nongnu.org

On Wed, Jun 06, 2018 at 04:36:16PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 06/06/2018 04:24 PM, Eduardo Habkost wrote:
> > On Tue, Jun 05, 2018 at 11:45:03AM -0300, Philippe Mathieu-Daud=E9 wr=
ote:
> > [... something about config files ...]
> >>> And after that, the following would run all "console" tests:
> >>>
> >>>   avocado run -t console
> >>>
> >>> How does this sound?
> >>
> >> For my use cases this doesn't worry me, I'll let Eduardo/Fam opine a=
bout
> >> use_test_dir_when_no_references_given.
> >=20
> > Well, I can't give an opinion because I couldn't understand
> > what's the final goal here.
>=20
> You cut too much, the relevant part is:
>=20
>   On 05/30/2018 10:06 PM, Cleber Rosa wrote:
>   > But at the same, there are security implications: `list` won't
>   > load/execute any test code (different from, say, standard Python
>   > unittests), while "run" obviously will.  So "avocado run" may end u=
p
>   > running what users don't want if a malicious user controls
>   > "$avocado_datadir_paths_test_dir".

The final goal still isn't clear to me.  Why would somebody want
to use $avocado_datadir_paths_test_dir instead of just specifying
"." in the command-line?


>=20
> >=20
> > What exactly is missing in the current solution?  Why
> > "avocado run -t console ." wouldn't work?
>=20
> It doesn't work in out-of-tree builds, I have to use the full path:
>=20
>   >>   build_dir$ avocado run
> /full/path/to/sources/qemu/tests/acceptance/boot_linux_console.py

Isn't the symlink you suggested a better solution than requiring
the user to edit a config file?

--=20
Eduardo
