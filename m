Received: from eggs.gnu.org ([2001:4830:134:3::10]:36661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drsi0-0007i0-Aw
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drshz-0008KF-GQ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:27:04 -0400
Date: Tue, 12 Sep 2017 17:26:56 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1767007484.5449466.1505251616671.JavaMail.zimbra@redhat.com>
In-Reply-To: <7d63b366-37a4-bfbe-790b-9a1ceb0d2893@redhat.com>
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-5-pbonzini@redhat.com>
	<7d63b366-37a4-bfbe-790b-9a1ceb0d2893@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/10] qemu-iotests: cleanup and fix search
 for programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org



> > +then
> > +    if [ -x "$build_iotests/qemu" ]; then
> > +        export QEMU_PROG="$build_iotests/qemu"
> > +    elif [ -x "$build_root/$arch-softmmu/qemu-system-$arch" ]; then
> > +        export QEMU_PROG="$build_root/$arch-softmmu/qemu-system-$arch"
> > +    else
> > +        pushd "$build_root" > /dev/null
> 
> Shouldn't you check for failure to change directories?
>  
> >  export PWD=`pwd`
> >  
> > @@ -30,28 +31,6 @@ export _QEMU_HANDLE=0
> >  # make sure we have a standard umask
> >  umask 022
> >  
> > -# $1 = prog to look for, $2* = default pathnames if not found in $PATH
> > -set_prog_path()
> > -{
> > -    p=`command -v $1 2> /dev/null`
> > -    if [ -n "$p" -a -x "$p" ]; then
> 
> Urrgh - your use of [ -a ] was pre-existing, and you just moved it.

And same for pushd...

Paolo
