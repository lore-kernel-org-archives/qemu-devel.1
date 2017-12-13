Received: from eggs.gnu.org ([2001:4830:134:3::10]:33489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePDNn-0004mh-Pg
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePDNi-0004eQ-O7
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:11:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePDNi-0004eB-Dh
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:11:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 780346A7CD
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 20:11:53 +0000 (UTC)
Date: Wed, 13 Dec 2017 20:11:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171213201145.GB8501@work-vm>
References: <20171212135600.14965-1-dgilbert@redhat.com>
	<20171212182353.hme665vsaohxdvzv@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212182353.hme665vsaohxdvzv@eukaryote>
Subject: Re: [Qemu-devel] [PATCH] docs: Convert migration.txt to rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com

* Kashyap Chamarthy (kchamart@redhat.com) wrote:
> On Tue, Dec 12, 2017 at 01:56:00PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Mostly just manual conversion with very minor fixes.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  docs/devel/{migration.txt => migration.rst} | 326 +++++++++++++++-------------
> >  1 file changed, 176 insertions(+), 150 deletions(-)
> >  rename docs/devel/{migration.txt => migration.rst} (74%)
> 
> Hey Dave,
> 
> A good chunk of changes I suggest are pre-existing, so take it with a
> grain of salt :-).  I'm ambivalent on whether to keep the conversion to
> rST and the other rST syntax changes separate.  Maybe we can keep in one
> change, as this doesn't impact backports in terms of code /
> functionality.

I'd like to fix the non-rST fixes some other time; there's plenty wrong
with the actual contents of this file.
(I need to pull in a fix from Jay Zhou before resending this actually).

> [...]
> 
> > +State Live Migration
> > +====================
> >  
> >  This is used for RAM and block devices.  It is not yet ported to vmstate.
> >  <Fill more information here>
> 
> Not this patch's problem, but do we have the more information that is to
> be filled in above?

Oh yes, plenty!

> [...]
> 
> >  You can use any internal state that you need using the opaque void *
> >  pointer that is passed to all functions.
> > @@ -83,7 +96,8 @@ pointer that is passed to all functions.
> >  The important functions for us are put_buffer()/get_buffer() that
> 
> Might want to highlight the fuctions (as you call them as important)
> with back ticks (and some spacing): `put_buffer()` / `get_buffer()`.

OK, I've done a bunch of these highlights you suggest; one or two
questions below.

> >  allow to write/read a buffer into the QEMUFile.
> >  
> > -=== How to save the state of one device ===
> > +Saving the state of one device
> > +==============================
> >  
> >  The state of a device is saved using intermediate buffers.  There are
> >  some helper functions to assist this saving.
> > @@ -97,30 +111,34 @@ associated with a series of fields saved.  The save_state always saves
> 
> Here too: s/save_state/``save_state``/
> 
> (And other occurrences throughout the doc.)
> 
> >  the state as the newer version.  But load_state sometimes is able to
> 
> s/load_state/``load_state``/
> 
> (And other occurrences throughout the doc.)
> 
> >  load state from an older version.
> >  
> > -=== Legacy way ===
> > +Legacy way
> > +----------
> >  
> >  This way is going to disappear as soon as all current users are ported to VMSTATE.
> >  
> >  Each device has to register two functions, one to save the state and
> >  another to load the state back.
> 
> [...]
> 
> >  The important functions for the device state format are the save_state
> >  and load_state.  Notice that load_state receives a version_id
> >  parameter to know what state format is receiving.  save_state doesn't
> >  have a version_id parameter because it always uses the latest version.
> 
> In the above paragrah, too (``save_state``, ``load_state``).
> 
> Also s/version_id/'version_id'/g
> 
> > -=== VMState ===
> > +VMState
> > +-------
> >  
> 
> [...]
> 
> >  We are declaring the state with name "pckbd".
> >  The version_id is 3, and the fields are 4 uint8_t in a KBDState structure.
> >  We registered this with:
> >  
> > +.. code:: c
> > +
> >      vmstate_register(NULL, 0, &vmstate_kbd, s);
> >  
> >  Note: talk about how vmstate <-> qdev interact, and what the instance ids mean.
> 
> Not introduced in this patch, but: s/ids/IDs/
> 
> Two points:
> 
> - I think the above is a TODO item; so you can use:
> 
>     .. TODO (dgilbert):: talk about how vmstate <-> qdev interact, and
>     what the instance ids mean.
> 
>   As that'll keep it only in the source rST; but not in the rendered
>   version.

I'd rather leave the items rendered, otherwise they have even less
chance of being fixed.

> - Also, other minor thing (again, pre-existing): capitalize all the
>   things like s/tcp/TCP; s/unix/UNIX/ where appropriate.
> 
> > @@ -159,7 +181,8 @@ Note: talk about how vmstate <-> qdev interact, and what the instance ids mean.
> >  You can search for VMSTATE_* macros for lots of types used in QEMU in
> 
> Maybe: s/VMSTATE_*/``VMSTATE_*``/
> 
> >  include/hw/hw.h.
> >  
> > -=== More about versions ===
> > +More about versions
> > +-------------------
> >  
> >  Version numbers are intended for major incompatible changes to the
> >  migration of a device, and using them breaks backwards-migration
> > @@ -183,7 +206,8 @@ function is deprecated and will be removed when no more users are left.
> >  Saving state will always create a section with the 'version_id' value
> >  and thus can't be loaded by any older QEMU.
> 
> Also, not in this patch, but keeping up with the theme of highlighting
> function names:
> 
>     s/load_state_old()/``load_state_old()``/
>    
> And other fields and strings (you can use a single quote, or a back tick
> for italics; whatever you choose, might want to keep it consistent):
> 
>     s/version_id/'version_id'/
> 
> > -===  Massaging functions ===
> > +Massaging functions
> > +-------------------
> 
> [...]
> 
> > -=== Subsections ===
> > +Subsections
> > +-----------
> >  
> >  The use of version_id allows to be able to migrate from older versions
> 
> s/version_id/'version_id'/  (or `version_id`, if you prefer italics)
> 
> Again, not in this patch, but noticed in the rendered version locally:
> 
> s/post_load()/``post_load()``/
>  
> [...]
> 
> >  Here we have a subsection for the pio state.  We only need to
> >  save/send this state when we are in the middle of a pio operation
> 
> s/ide_drive_pio_state_needed()/``ide_drive_pio_state_needed()``/
> 
> > @@ -305,14 +331,11 @@ to send a subsection allows backwards migration compatibility when
> 
> [...]
> 
> > +Not sending existing elements
> > +-----------------------------
> >  
> >  Sometimes members of the VMState are no longer needed;
> 
> Pre-existing: s/;/:/
> 
> [...]
> 
> > +Return path
> > +-----------
> 
> [...]
> 
> Pre-existing, and not this patch's problem.  Noticed in my HTML render:
> in this section, you might to highlight (double back ticks) the
> function:
> 
>     ``qemu_file_get_return_path(QEMUFile* fwdpath)``
> 
> [...]
> 
> > +Postcopy
> > +========
> 
> [...]
> 
> > -=== Enabling postcopy ===
> > +Enabling postcopy
> > +-----------------
> 
> [...]
> 
> Not in this patch, but in this section, 'migrate_set_speed' is
> mentioned; since it's a QMP command, you might want to highlith it:
> ``migrate_set_speed``
> 
> Also, from this section, you might want to use adminitions like:
> 
>     .. note::
>         During the postcopy phase, the bandwidth limits set using
>         migrate_set_speed is ignored (to avoid delaying requested pages
>         that the destination is waiting for).
> 
> Use this wherever you see fit in the document.
> 
> [...]
> 
> >  Source behaviour
> > +----------------
> >  
> >  Until postcopy is entered the migration stream is identical to normal
> >  precopy, except for the addition of a 'postcopy advise' command at
> > @@ -423,11 +453,10 @@ the beginning, to tell the destination that postcopy might happen.
> >  When postcopy starts the source sends the page discard data and then
> >  forms the 'package' containing:
> >  
> > -   Command: 'postcopy listen'
> > -   The device state
> 
> In my local Sphinx-based HTML rendering, the above "The device state"
> ended up being bold somehow.

Any idea why? It's fine both in vim and rst2html-3's output.

> > -      A series of sections, identical to the precopy streams device state stream
> > -      containing everything except postcopiable devices (i.e. RAM)
> > -   Command: 'postcopy run'
> > +   - Command: 'postcopy listen'
> > +   - The device state
> > +      A series of sections, identical to the precopy streams device state stream containing everything except postcopiable devices (i.e. RAM)
> 
> Might want to wrap this long line (and other places); as it's causing an
> extra new line in my local rendering.

Yes, done (as per Peter's comments); it took me a while to figure out
how to wrap them in lists.

> > +   - Command: 'postcopy run'
> >  
> >  The 'package' is sent as the data part of a Command: 'CMD_PACKAGED', and the
> 
> s/CMD_PACKAGED/``CMD_PACKAGED``/g ?
> 
> 
> [...]
> 
> > +- On receipt of CMD_PACKAGED (1)
> > +   All the data associated with the package - the ( ... ) section in the diagram - is read into memory, and the main thread recurses into qemu_loadvm_state_main to process the contents of the package (2) which contains commands (3,6) and devices (4...)
> > +
> > +- On receipt of 'postcopy listen' - 3 -(i.e. the 1st command in the package)
> > +   a new thread (a) is started that takes over servicing the migration stream, while the main thread carries on loading the package.   It loads normal background page data (b) but if during a device load a fault happens (5) the returned page (c) is loaded by the listen thread allowing the main threads device load to carry on.
> > +
> > +- The last thing in the CMD_PACKAGED is a 'RUN' command (6)
> > +   letting the destination CPUs start running.  At the end of the CMD_PACKAGED (7) the main thread returns to normal running behaviour and is no longer used by migration, while the listen thread carries on servicing page data until the end of migration.
> 
> Super long lines, needs wrapping.  Here too something seem to cause
> needless "bold" text in my Sphinx-based HTML rendering.
> 
> > +
> > +Postcopy states
> > +---------------
> 
> [...]
> 
> There's a list in this document.  You might want to 'listify' it (using
> numbers, alphabets, etc), like you did it in other places.
> 
> [...]
> 
> > -=== Postcopy with hugepages ===
> > +Postcopy with hugepages
> > +-----------------------
> 
> Here too, noticed after reading the rendered version; you might want to
> highlight the QEMU command-line parameters & file system paths using the
> verbatim (``):
> 
>     -mem-path
>     /dev/hugepages
>     -mem-prealloc
> 
> [...]
> 
> -- 
> /kashyap

Thanks,

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
