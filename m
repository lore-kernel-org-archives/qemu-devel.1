Received: from eggs.gnu.org ([2001:4830:134:3::10]:45086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gG3z9-0001iT-Rf
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gG3z8-0007lH-TA
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:25:15 -0400
Date: Fri, 26 Oct 2018 12:25:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181026152501.GG3902@habkost.net>
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-10-crosa@redhat.com>
	<b590e7a3-c0e8-f39b-8a9b-b56d4804a6bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b590e7a3-c0e8-f39b-8a9b-b56d4804a6bc@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/10] scripts/qemu.py: use a
 more consistent docstring style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On Mon, Oct 08, 2018 at 03:44:14PM -0400, John Snow wrote:
> 
> 
> On 10/04/2018 12:18 PM, Cleber Rosa wrote:
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  dtc             |  2 +-
> >  scripts/qemu.py | 65 +++++++++++++++++++++++++++++++------------------
> >  2 files changed, 42 insertions(+), 25 deletions(-)
> > 
> > diff --git a/dtc b/dtc
> > index 88f18909db..e54388015a 160000
> > --- a/dtc
> > +++ b/dtc
> > @@ -1 +1 @@
> > -Subproject commit 88f18909db731a627456f26d779445f84e449536
> > +Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index f099ce7278..7abe26de69 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -53,9 +53,9 @@ class QEMUMachineAddDeviceError(QEMUMachineError):
> >      """
> >  
> >  class MonitorResponseError(qmp.qmp.QMPError):
> > -    '''
> > +    """
> >      Represents erroneous QMP monitor reply
> > -    '''
> > +    """
> 
> This seems obviously correct, as per the Python Dogma Handbook ...
> 
[...]
> >      def add_fd(self, fd, fdset, opaque, opts=''):
> > -        '''Pass a file descriptor to the VM'''
> > +        """
> > +        Pass a file descriptor to the VM
> > +        """
> 
> However, is it established practice among ne'er-do-wells to format
> one-line docstrings as three-liners? (And without punctuation to boot --
> for shame!)
> 
> PEP257 suggests that one-liners are allowed, but doesn't seem to
> necessitate their usage. Does this kind of change have any kind of benefit?

I don't mind having one-line docstrings.  But if we're already
touching multiple docstrings, consistency with the rest of the
module code sounds nice.

I'm queueing this on python-next.

-- 
Eduardo
