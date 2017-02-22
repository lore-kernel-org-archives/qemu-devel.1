Received: from eggs.gnu.org ([2001:4830:134:3::10]:33082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cgdfH-0000dU-Tb
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 15:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cgdfG-00050x-W8
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 15:37:31 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:36745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cgdfG-00050j-S4
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 15:37:30 -0500
Received: by mail-ot0-x241.google.com with SMTP id l26so1463435ota.3
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 12:37:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487009088-23891-1-git-send-email-ashijeetacharya@gmail.com>
References: <1487009088-23891-1-git-send-email-ashijeetacharya@gmail.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 23 Feb 2017 02:07:28 +0530
Message-ID: <CAC2QTZayvXvBWcbL73evwFzJLjNY9fRn0HwB8ncrZfh3MMj+ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4] migrate: Introduce a 'dc->vmsd' check
 to avoid segfault for --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "dgilbert@redhat.com" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Ashijeet Acharya <ashijeetacharya@gmail.com>

On Mon, Feb 13, 2017 at 11:34 PM, Ashijeet Acharya
<ashijeetacharya@gmail.com> wrote:
> Commit a3a3d8c7 introduced a segfault bug while checking for
> 'dc->vmsd->unmigratable' which caused QEMU to crash when trying to add
> devices which do no set their 'dc->vmsd' yet while initialization.
> Place a 'dc->vmsd' check prior to it so that we do not segfault for
> such devices.
>
> NOTE: This doesn't compromise the functioning of --only-migratable
> option as all the unmigratable devices do set their 'dc->vmsd'.
>
> Introduce a new function check_migratable() and move the
> only_migratable check inside it, also use stubs to avoid user-mode qemu
> build failures.
>
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
> Changes in v4:
> - introduce new check_migratable() function and use stubs
> Changes is v3:
> - move only_migratable check inside device_set_realized() to avoid code
> - duplication
> - I have dropped Juan's R-b tag for this one
> Changes in v2:
> - place dc->vmsd check in hw/usb/bus.c as well
> ---
>  hw/core/qdev.c                |  7 +++++++
>  hw/usb/bus.c                  | 19 -------------------
>  include/migration/migration.h |  3 +++
>  migration/migration.c         | 15 +++++++++++++++
>  qdev-monitor.c                |  9 ---------
>  stubs/vmstate.c               |  6 ++++++
>  6 files changed, 31 insertions(+), 28 deletions(-)
>

Just a small reminder about this patch, although I am not available
actively until this weekend due to exams.

Thanks
Ashijeet
