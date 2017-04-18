Received: from eggs.gnu.org ([2001:4830:134:3::10]:42601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d0VhD-0008FR-Ne
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 12:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d0VhC-0008S1-3h
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 12:09:39 -0400
MIME-Version: 1.0
References: <20170401155751.14322-1-mreitz@redhat.com>
In-Reply-To: <20170401155751.14322-1-mreitz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Apr 2017 16:09:21 +0000
Message-ID: <CAJ+F1CKvr6YfvxYYfcPa_Tc-aPNJk+GtcSGKi9NHHXd=Y=21ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for-3.0 0/4] block: Add qcow2-rust block
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

woot! Happy birthday!

On Tue, Apr 18, 2017 at 7:58 PM Max Reitz <mreitz@redhat.com> wrote:

> The issues of using C are well understood and nobody likes it. Let's use
> a better language. C++ is not a better language, Rust is. Everybody
> loves Rust. Rust is good. Rust is hip. It will attract developers, it
> will improve code quality, it will improve performance, it will even
> improve your marriage. Rust is the future and the future is now.
>
> As the block layer, let's show our commitment to the future by replacing
> one of our core parts, the the LEGACY (Bah! Yuck! Ugh!) qcow2 driver, by
> a shiny (Oooh! Aaah!) Rust driver. Much better. My VMs now run thrice as
> fast. Promise.
>
>
> Max Reitz (4):
>   block: Add Rust interface
>   block/qcow2-rust: Add qcow2-rust block driver
>   block/qcow2-rust: Add partial write support
>   block/qcow2-rust: Register block driver
>
>  configure                                  |    2 +
>  Makefile                                   |    6 +-
>  Makefile.target                            |    2 +-
>  block/Makefile.objs                        |    1 +
>  block/qcow2-rust.c                         |   38 ++
>  block/rust/Cargo.toml                      |   10 +
>  block/rust/src/interface/c_constants.rs    |    8 +
>  block/rust/src/interface/c_functions.rs    |   37 +
>  block/rust/src/interface/c_structs.rs      |  587 ++++++++++++++++
>  block/rust/src/interface/mod.rs            | 1012
> ++++++++++++++++++++++++++++
>  block/rust/src/lib.rs                      |   12 +
>  block/rust/src/qcow2/allocation.rs         |  162 +++++
>  block/rust/src/qcow2/io.rs                 |  439 ++++++++++++
>  block/rust/src/qcow2/mod.rs                |  347 ++++++++++
>  block/rust/src/qcow2/on_disk_structures.rs |   59 ++
>  block/rust/src/qcow2/refcount.rs           |   96 +++
>  16 files changed, 2816 insertions(+), 2 deletions(-)
>  create mode 100644 block/qcow2-rust.c
>  create mode 100644 block/rust/Cargo.toml
>  create mode 100644 block/rust/src/interface/c_constants.rs
>  create mode 100644 block/rust/src/interface/c_functions.rs
>  create mode 100644 block/rust/src/interface/c_structs.rs
>  create mode 100644 block/rust/src/interface/mod.rs
>  create mode 100644 block/rust/src/lib.rs
>  create mode 100644 block/rust/src/qcow2/allocation.rs
>  create mode 100644 block/rust/src/qcow2/io.rs
>  create mode 100644 block/rust/src/qcow2/mod.rs
>  create mode 100644 block/rust/src/qcow2/on_disk_structures.rs
>  create mode 100644 block/rust/src/qcow2/refcount.rs
>
> ---
>
> Yes, I'm late. I thought somebody else would do something but nobody
> did. It's still April, though, so I think I'm all good. Also, it's my
> birthday today so you're not allowed to complain!
>
> I could have waited until next year, but I'm afraid it would no longer
> have been funny by then because we might truly have Rust code in master
> then...
>
> --
> 2.12.2
>
>
> --
Marc-Andr=C3=A9 Lureau
