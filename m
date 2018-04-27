Received: from eggs.gnu.org ([2001:4830:134:3::10]:53146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fBrLC-0008R0-IA
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fBrLB-0007RX-NE
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:34:22 -0400
Date: Thu, 26 Apr 2018 21:34:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180427003414.GV29865@localhost.localdomain>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87in8qf2w3.fsf@dusky.pond.sub.org>
	<62dba5cf-b497-1a98-0af5-971e169a3458@redhat.com>
	<877eou2nek.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877eou2nek.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test devices
 with all machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, Apr 26, 2018 at 01:54:43PM +0200, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 17.04.2018 14:12, Markus Armbruster wrote:
> >> Thomas Huth <thuth@redhat.com> writes:
> >> 
> >>> Many device introspection crashes only happen if you are using a
> >>> certain machine, e.g.:
> >>>
> >>> $ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=qtest -qmp stdio
> >>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
> >>>  "package": "build-all"}, "capabilities": []}}
> >>> { 'execute': 'qmp_capabilities' }
> >>> {"return": {}}
> >>> { 'execute': 'device-list-properties',
> >>>   'arguments': {'typename': 'macio-newworld'}}
> >>> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
> >>> Device 'serial0' is in use
> >>> Aborted (core dumped)
> >>>
> >>> To be able to catch these problems, let's extend the device-introspect
> >>> test to check the devices on all machine types. Since this is a rather
> >>> slow operation, the test is only run in "SPEED=slow" mode.
> >> 
> >> If the device works with one machine type, it has a decent chance to
> >> work with others, too.  Thus, testing each device with every machine
> >> type is overkill.  I appreciate having overkill as an option :)
> >> 
> >> What I'd like to see for a quick "make check" is testing each device
> >> once.  That should flush out most bugs.  
> >
> > That's already done with the "none" machine.
> 
> I was too terse.  We test each device with -machine none for every
> target.  Fine if that's quick enough.  If not, we might want to reduce
> redundancy there.
> 
> Actually, a worse offender in the "waste everybody's time via redunancy"
> department could be qom-test.
> 
> > Anyway, do you think my patch here is useful and has a chance of getting
> > included? I.e. shall I re-spin this as a non-RFC patch? Or shall we
> > rather wait for Eduardo's python-based tests to get included into the
> > repository?
> 
> I don't mind having make check SPEED=slow run more extensive tests.
> Assuming we actually run them at least once in a while, which seems
> doubtful.

The infrastructure for Python-based tests might take a while to
be included, as I'm busy with other stuff right now.  I wouldn't
mind including this patch, as long as you don't mind seeing it
deleted after we reimplement it in Python.

-- 
Eduardo
