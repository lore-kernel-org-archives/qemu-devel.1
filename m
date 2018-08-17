Received: from eggs.gnu.org ([2001:4830:134:3::10]:45626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fqTYB-0001c0-GY
	for Qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fqTY9-0006wc-Nw
	for Qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:27:39 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180814084047.GD5025@dhcp-200-186.str.redhat.com>
Date: Thu, 16 Aug 2018 21:27:27 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <D08F395C-E55A-4FF1-9844-02B606FDDF8E@gmail.com>
References: <20180730212249.16418-1-programmingkidx@gmail.com>
	<5679ec6f-e2d7-e139-1b56-304540c89977@redhat.com>
	<f6fcbd58-2462-d432-a038-cc13bb0dcf23@redhat.com>
	<20180814084047.GD5025@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img.c: increase spacing between
 commands in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Qemu-devel@nongnu.org


> On Aug 14, 2018, at 4:40 AM, Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> Am 13.08.2018 um 20:19 hat Eric Blake geschrieben:
>> On 08/13/2018 11:56 AM, Max Reitz wrote:
>>>=20
>>> Ah, hm, so much for that.  Hm...  I don't quite know what to think =
of
>>> this.  It does indeed improve legibility.  But the question is =
whether
>>> --help should be as condensed as possible, and if the user finds it =
hard
>>> to read, whether they should not just open the man page...
>>>=20
>>> Then again, our --help text already has 102 lines.
>>>=20
>>> Let me just think about it for a bit longer. :-)
>>> (And see whether others have opinions.)
>>=20
>> And I've already expressed my opinion that it is already rather long, =
where
>> making it longer is not necessarily making it smarter.
>=20
> I think if we want to improve the help text, we should split it up.
>=20
> $ qemu-img --help
> qemu-img version 2.12.94 (v3.0.0-rc4-5-g4fe9c3e13d-dirty)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project =
developers
> usage: qemu-img [standard options] command [command options]
> QEMU disk image utility
>=20
>    '-h', '--help'       display this help and exit
>    '-V', '--version'    output version information and exit
>    '-T', '--trace'      =
[[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]
>                         specify tracing options
>=20
> Commands:
>=20
>    amend               Change options of an existing disk image
>    bench               Run benchmarks on a given disk image
>    check               Check the disk image for consistency or repair =
it
>    commit              Merge the disk image into its backing file
>    ...
>=20
> Run 'qemu-img <command> --help' for details.
>=20
> See <https://qemu.org/contribute/report-a-bug> for how to report bugs.
> More information on the QEMU project at <https://qemu.org>.
>=20
> $ qemu-img check --help
> usage: qemu-img check [--object objectdef] [--image-opts] [-q] [-f =
fmt] [--output=3Dofmt] [-r [leaks | all]] [-T src_cache] [-U] filename
>=20
> Command parameters:
>  -f        'fmt' is the disk image format. It is guessed automatically
>            in most cases.
>=20
>  -q        use Quiet mode - do not print any output (except errors).
>=20
>  -r        tries to repair any inconsistencies that are found during =
the
>            check. '-r leaks' repairs only cluster leaks, whereas '-r
>            all' fixes all kinds of errors, with a higher risk of
>            choosing the wrong fix or hiding corruption that has =
already
>            occurred.
>=20
>  -T        'src_cache' is the cache mode used to read input disk =
images,
>            the valid options are the same as for the 'cache' option.
>=20
>  --object  'objectdef' is a QEMU user creatable object definition. See
>            the qemu(1) manual page for a description of the object
>            properties. The most common object type is a 'secret', =
which
>            is used to supply passwords and/or encryption keys.
>=20
>  --output  'ofmt' is 'human' for human-readable output (default) or
>            'json' for JSON output.
>=20
> Examples:
>=20
>    ...
>=20
> Kevin


I am by no means an expert at qemu-img. But I did try my best to create =
what I think should be the new output for qemu-img <command> --help. =
This is just the text I plan on using in a future patch. It is easier to =
read right now than it will be in patch form, so please let me know if =
there are any errors in this documentation. Thank you.


<amend>

usage: qemu-img amend [--object objectdef] [--image-opts] [-p] [-q] [-f =
fmt]
[-t cache] -o options filename

Command parameters:
 -f             'fmt' is the disk image format. It is guessed =
automatically
                in most cases.

--image-opts    Treat filename as a set of image options, instead of a =
plain
                filename.

 -o             Used with a comma separated list of format specific =
options in a
                name=3Dvalue format. Use "-o ?" for an overview of the =
options
                supported by the used format

--object        'objectdef' is a QEMU user creatable object definition. =
See the
                qemu(1) manual page for a description of the object =
properties.
                The most common object type is a 'secret', which is used =
to
                supply passwords and/or encryption keys.

 -p             Display progress bar. If the -p option is not used for a =
command
                that supports it, the progress is reported when the =
process
                receives a "SIGUSR1" signal.

 -q             Quiet mode - do not print any output (except errors). =
There's no
                progress bar in case both -q and -p options are used.

 -t             Specifies the cache mode that should be used with the
                destination file.

Example:
    qemu-img amend -o compat=3D0.10 -f qcow2 image.qcow2


<bench>

usage: qemu-img bench [-c count] [-d depth] [-f fmt]
[--flush-interval=3Dflush_interval] [-n] [--no-drain] [-o offset]
[--pattern=3Dpattern] [-q] [-s buffer_size] [-S step_size] [-t cache] =
[-w] [-U]
filename

Command parameters:
 -c                  Number of I/O requests to perform.

 -d                  Number of I/O requests done in parallel.

 -f                  fmt' is the disk image format. It is guessed =
automatically
                     in most cases.

 --flush-interval    How often a flush should take place.

 -n                  Use native AIO backend if possible.

 --no-drain          Issue a flush without draining the request queue =
first.

 -o                  The starting position.

 --pattern           The byte pattern used to in write tests.

 -q                  Quiet mode - do not print any output (except =
errors).
                     There's no progress bar in case both -q and -p =
options are
                     used.

 -s                  buffer_size in bytes.

 -S                  Increases current position by step_size.

 -t                  Specifies the cache mode that should be used with =
the
                     destination file.

 -w                  Perform write test.

 -U                  Open the image in shared mode, allowing other QEMU
                     processes to open it in write mode. This option is =
only
                     allowed when opening images in read-only mode.

Example:
    qemu-img bench -c 20000 -d 50000 -f qcow2 image.qcow2


<check>

usage: qemu-img check [--object objectdef] [--image-opts] [-q] [-f fmt]
[--output=3Dofmt] [-r [leaks | all]] [-T src_cache] [-U] filename

Command parameters:
 -f         'fmt' is the disk image format. It is guessed automatically =
in most
            cases.

 -q         Use Quiet mode - do not print any output (except errors).

 -r         Tries to repair any inconsistencies that are found during =
the check.
            '-r leaks' repairs only cluster leaks, whereas '-r all' =
fixes all
            kinds of errors, with a higher risk of choosing the wrong =
fix or
            hiding corruption that has already occurred.

 -T         'src_cache' is the cache mode used to read input disk =
images, the
            valid options are the same as for the 'cache' option.

 --object   'objectdef' is a QEMU user creatable object definition. See =
the
            qemu(1) manual page for a description of the object =
properties. The
            most common object type is a 'secret', which is used to =
supply
            passwords and/or encryption keys.

 --output   'ofmt' is 'human' for human-readable output (default) or =
'json' for
            JSON output.

Example:
    qemu-img check image.qcow2


<commit>

usage: qemu-img commit [--object objectdef] [--image-opts] [-q] [-f fmt]
[-t cache] [-b base] [-d] [-p] filename

Command parameters:
 -b            The base image or backing file.

 -d            Skip emptying filename.

 -f            'fmt' is the disk image format. It is guessed =
automatically
               in most cases.

 --image-opts  Treat filename as a set of image options, instead of a =
plain
               filename.

 --object      'objectdef' is a QEMU user creatable object definition. =
See the
               qemu(1) manual page for a description of the object =
properties.
               The most common object type is a 'secret', which is used =
to
               supply passwords and/or encryption keys.

 -p            Display progress bar. If the -p option is not used for a =
command
               that supports it, the progress is reported when the =
process
               receives a "SIGUSR1" signal.

 -q            Quiet mode - do not print any output (except errors). =
There's no
               progress bar in case both -q and -p options are used.

 -t            Specifies the cache mode that should be used with the
               destination file.

Example:
    qemu-img commit image.qcow2


<compare>

usage: qemu-img compare [--object objectdef] [--image-opts] [-f fmt] [-F =
fmt]
[-T src_cache] [-p] [-q] [-s] [-U] filename1 filename2

Command parameters:
 -f                 First image format.

 -F                 Second image format.

 --image-opts       Treat filename as a set of image options, instead of =
a plain
                    filename.

 -T                 Specifies the cache mode that should be used with =
the source
                    file.

 --object           'objectdef' is a QEMU user creatable object =
definition. See
                    the qemu(1) manual page for a description of the =
object
                    properties. The most common object type is a =
'secret', which
                    is used to supply passwords and/or encryption keys.

 -p                 Display progress bar. If the -p option is not used =
for a
                    command that supports it, the progress is reported =
when the
                    process receives a "SIGUSR1" signal.

 -q                 Quiet mode - do not print any output (except =
errors).
                    There's no progress bar in case both -q and -p =
options are
                    used.

 -s                 Enable strict mode. Comparisons differ when image =
sizes
                    differ or if a sector is allocated in one image and =
not
                    allocated in the other image.

 -U                 Open the image in shared mode, allowing other QEMU
                    processes to open it in write mode. This option is =
only
                    allowed when opening images in read-only mode.

Example:
    qemu-img compare image1.qcow image2.qcow2


<convert>

usage: qemu-img convert [--object objectdef] [--image-opts]
[--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache]
[-T src_cache] [-O output_fmt] [-B backing_file] [-o options]
[-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size]
[-m num_coroutines] [-W] filename [filename2 [...]] output_filename

Command parameters:
 -B                      Force the output image to be created as a copy =
on write
                         image of the specified base image.

 -c                      Compress the output image file.

 -f                      'fmt' is the disk image format. It is guessed
                         automatically in most cases.

 --image-opts            Indicates that the source filename parameter is =
to be
                         interpreted as a full option string, not a =
plain
                         filename.

 -l                      Specifies a snapshot parameter.

 -m                      Number of parallel coroutines for the convert =
process

 -n                      Skip the creation of the target volume.

 -O                      Format of the output file.

 -o                      Allows for specifying options like virtual disk =
size.

 --object                'objectdef' is a QEMU user creatable object =
definition.
                         See the qemu(1) manual page for a description =
of the
                         object properties. The most common object type =
is a
                         'secret', which is used to supply passwords =
and/or
                         encryption keys.

 -p                      Display progress bar. If the -p option is not =
used for
                         a command that supports it, the progress is =
reported
                         when the process receives a "SIGUSR1" signal.

 -q                      Quiet mode - do not print any output (except =
errors).
                         There's no progress bar in case both -q and -p =
options
                         are used.

 -S                      The consecutive number of bytes (defaults to =
4k) that
                         must contain only zeros for qemu-img to create =
a sparse
                         image during conversion.

 -s                      The name or ID of the snapshot to use.

 -T                      Specifies the cache mode that should be used =
with the
                         source file.

 -t                      Specifies the cache mode that should be used =
with the
                         destination file.

--target-image-opts      Indicates whether the source filename includes =
options.

 -U                      Open the image in shared mode, allowing other =
QEMU
                         processes to open it in write mode. This option =
is only
                         allowed when opening images in read-only mode.

 -W                      Allow out-of-order writes to the destination. =
This
                         option improves performance, but is only =
recommended
                         for preallocated devices like host devices or =
other raw
                         block devices.

Example:
    qemu-img convert -f raw -O qcow2 image.img image.qcow2


<create>

usage: qemu-img create [--object objectdef] [-q] [-f fmt] [-b =
backing_file]
[-F backing_fmt] [-u] [-o options] filename [size]

Command parameters:
 -b             The backing file used to base the output file on.

 -f             The format of the output file.

 -F             The format of the backing file.

 -u             Create the image file even if the backing file cannot be =
opened.

 -o             Allows for specifying options like virtual disk size.

--object        'objectdef' is a QEMU user creatable object definition.
                See the qemu(1) manual page for a description of the
                object properties. The most common object type is a
                'secret', which is used to supply passwords and/or
                encryption keys.

Example:
    qemu-img create -f qcow2 image.qcow2 10G


<dd>

usage: qemu-img dd [-f fmt] [-O output_fmt] [bs=3Dblock_size] =
[count=3Dblocks]
[skip=3Dblocks] if=3Dinput of=3Doutput

Command parameters:
 bs                 Size of the blocks used in reading and writing (512 =
bytes is
                    the default).

 count              The limit to how many blocks to read.

 -f                 Format of the input file.

 if                 The input file.

 -O                 Format of the output file.

 of                 The output file.

 skip               Number of blocks to skip.

Example:
    qemu-img dd if=3D/dev/cdrom -O raw of=3Dcd.iso


<info>

usage: qemu-img info [-f fmt] [--output=3Dofmt] [--backing-chain] =
filename

Command parameters:
 --backing-chain            Recursively enumerate thru each disk image =
in the
                            chain for information.

 -f                         The format of image file specified by =
filename.

--output                    The output format of this command. Can be =
"human" or
                            "json".

Example:
    qemu-img info image.qcow2


<map>

usage: qemu-img map [-f fmt] [--output=3Dofmt] filename

Command parameters:
 -f                 The format of the image file specified by filename.

--output            The output format of this command. Can be "human" or =
"json".

Example:
    qemu-img map image.qcow2


<measure>

usage: qemu-img measure [--output=3Dofmt] [-O output_fmt] [-o options] =
[--size N ]
[--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param]
filename

Command parameters:
 -f                 'fmt' is the disk image format. It is guessed
                    automatically in most cases.

 --image-opts       Indicates that the source filename parameter is to =
be
                    interpreted as a full option string, not a plain
                    filename.

 -l                 Specifies a snapshot parameter.

 -O                 Format of the output file.

 -o                 Allows for specifying options.

 --object           'objectdef' is a QEMU user creatable object =
definition. See
                    the qemu(1) manual page for a description of the =
object
                    properties. The most common object type is a =
'secret',
                    which is used to supply passwords and/or encryption =
keys.

 --output           'ofmt' is 'human' for human-readable output =
(default) or
                    'json' for JSON output.

 --size             If given act as if creating a new empty image file =
using
                    qemu-img create.

Example:
    qemu-img measure -O qcow2 --size 5G


<Snapshot>

usage: qemu-img snapshot [-l | -a snapshot | -c snapshot | -d snapshot ]
filename

Command parameters:
 -a                 Applies the snapshot.

 -c                 Create a snapshot.

 -d                 Deletes a snapshot.

 -l                 Lists all snapshots

Example:
    qemu-img snapshot -l image.qcow2


<Rebase>

usage: qemu-img rebase [-f fmt] [-t cache] [-T src_cache] [-p] [-u] -b
backing_file [-F backing_fmt] filename

Command parameters:
 -b         The new backing file.

 -F         The format for the new backing file.

 -f         'fmt' is the disk image format. It is guessed automatically =
in most
            cases.

 -T         Specifies the cache mode that should be used with the source =
file.

 -t         Specifies the cache mode that should be used with the =
destination
            file.

 -p         Display progress bar. If the -p option is not used for a =
command
            that supports it, the progress is reported when the process
            receives a "SIGUSR1" signal.

 -u         Operate in unsafe mode.

Example:
    qemu-img rebase -b backing.img diff.qcow2


<Resize>

usage: qemu-img resize [--shrink] [--preallocation=3Dprealloc] filename
[+ | -] size

Command parameters:
 --preallocation    When growing an image, specify how the additional =
image
                    area should be allocated on the host.

 --shrink           Informs qemu-img that the user acknowledges all loss =
of
                    data beyond the truncated image's end.

Example:
    qemu-img resize image.qcow2 20G
