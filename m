Received: from eggs.gnu.org ([2001:4830:134:3::10]:57387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbr0j-00041o-1R
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbr0e-0002KF-5A
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:51:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cbr0d-0002Jx-WC
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:51:48 -0500
Date: Thu, 9 Feb 2017 23:51:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170209155143.GA28593@lemon.lan>
References: <1486653206-14553-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1486653206-14553-1-git-send-email-den@openvz.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] kvm: report available guest crash
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 02/09 18:13, Denis V. Lunev wrote:
> Windows reports BSOD parameters through Hyper-V crash MSRs. This
> information is very useful for initial crash analysis and thus
> it would be nice to see it in the QEMU log file. There is suitable
> log mask for the purpose.
>=20
> Linux guest does not provide this information, but still it would
> be nice to log that we have crashed.
>=20
> Changes since v1:
> - patches resplit
> - created property to query crash parameters
> - crash parameters added to panic event

This has a compiling error:

/var/tmp/patchew-tester-tmp-fmkso1x2/src/hw/ppc/spapr_rtas.c: In function=
 =E2=80=98rtas_ibm_os_term=E2=80=99:
/var/tmp/patchew-tester-tmp-fmkso1x2/src/hw/ppc/spapr_rtas.c:337:5: error=
: the address of =E2=80=98error_abort=E2=80=99 will always evaluate as =E2=
=80=98true=E2=80=99 [-Werror=3Daddress]
     qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE, &error_abor=
t);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/var/tmp/patchew-tester-tmp-fmkso1x2/src/hw/ppc/spapr_rtas.c:337:5: error=
: too few arguments to function =E2=80=98qapi_event_send_guest_panicked=E2=
=80=99
In file included from /var/tmp/patchew-tester-tmp-fmkso1x2/src/hw/ppc/spa=
pr_rtas.c:42:0:
../qapi-event.h:48:6: note: declared here
 void qapi_event_send_guest_panicked(GuestPanicAction action, bool has_in=
fo, GuestPanicInformation *info, Error **errp);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
/var/tmp/patchew-tester-tmp-fmkso1x2/src/rules.mak:69: recipe for target =
'hw/ppc/spapr_rtas.o' failed
make[1]: *** [hw/ppc/spapr_rtas.o] Error 1
Makefile:318: recipe for target 'subdir-ppc64-softmmu' failed
