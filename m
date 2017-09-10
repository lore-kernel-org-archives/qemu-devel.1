Received: from eggs.gnu.org ([2001:4830:134:3::10]:36933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drAVr-0005DO-UP
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 18:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drAVn-0005Kg-Lc
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 18:15:35 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:36849 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drAVn-0005K4-AK
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 18:15:31 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<150472074219.24907.5510718414753398145.stgit@frigg.lan>
	<20170906212338.GD25558@flamenco>
Date: Mon, 11 Sep 2017 01:15:19 +0300
In-Reply-To: <20170906212338.GD25558@flamenco> (Emilio G. Cota's message of
	"Wed, 6 Sep 2017 17:23:38 -0400")
Message-ID: <87fubuxkso.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/20] instrument: Add basic control
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Emilio G Cota writes:

> On Wed, Sep 06, 2017 at 20:59:02 +0300, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> Makefile                           |    5 +++
>> configure                          |    1 +
>> instrument/Makefile.objs           |    2 +
>> instrument/control.c               |   28 +++++++++++++++++
>> instrument/control.h               |   44 +++++++++++++++++++++++++++
>> instrument/control.inc.h           |   25 ++++++++++++++++
>> instrument/error.h                 |   28 +++++++++++++++++
>> instrument/events.h                |   37 +++++++++++++++++++++++
>> instrument/events.inc.h            |   11 +++++++

> Am I the only one who finds this control vs. events division confusing?

Control is only for controlling instrumentation, and the header is used mai=
nly
inside the instrumentation directory. Wheread the events header is later go=
ing
to be included in every file that needs to trigger an instrumentation event.

> Also, do we need all these many files, even for the public API?

The only other header, error.h, is later used in many other files.


> And why the .inc's?

To keep tidy headers with documentation, and the implementation details sta=
shed
away on a separate file (like in the case of trace/).


> Thanks,
> 		E.


Cheers,
  Lluis
