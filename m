Received: from eggs.gnu.org ([2001:4830:134:3::10]:35391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cbvMq-0005E3-3n
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cbvMm-00012m-VO
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:31:00 -0500
Received: from mail-ve1eur01on0124.outbound.protection.outlook.com
	([104.47.1.124]:57503
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cbvMm-00011z-96
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:30:56 -0500
References: <1486653206-14553-1-git-send-email-den@openvz.org>
	<20170209155143.GA28593@lemon.lan>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <35a66eb3-f268-7802-4ab9-e56dd5e2475d@openvz.org>
Date: Thu, 9 Feb 2017 18:55:51 +0300
MIME-Version: 1.0
In-Reply-To: <20170209155143.GA28593@lemon.lan>
Content-Type: text/plain; charset="utf-8"
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 02/09/2017 06:51 PM, Fam Zheng wrote:
> On Thu, 02/09 18:13, Denis V. Lunev wrote:
>> Windows reports BSOD parameters through Hyper-V crash MSRs. This
>> information is very useful for initial crash analysis and thus
>> it would be nice to see it in the QEMU log file. There is suitable
>> log mask for the purpose.
>>
>> Linux guest does not provide this information, but still it would
>> be nice to log that we have crashed.
>>
>> Changes since v1:
>> - patches resplit
>> - created property to query crash parameters
>> - crash parameters added to panic event
> This has a compiling error:
>
> /var/tmp/patchew-tester-tmp-fmkso1x2/src/hw/ppc/spapr_rtas.c: In function=
 =E2=80=98rtas_ibm_os_term=E2=80=99:
> /var/tmp/patchew-tester-tmp-fmkso1x2/src/hw/ppc/spapr_rtas.c:337:5: error=
: the address of =E2=80=98error_abort=E2=80=99 will always evaluate as =E2=
=80=98true=E2=80=99 [-Werror=3Daddress]
>      qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE, &error_abor=
t);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-fmkso1x2/src/hw/ppc/spapr_rtas.c:337:5: error=
: too few arguments to function =E2=80=98qapi_event_send_guest_panicked=E2=
=80=99
> In file included from /var/tmp/patchew-tester-tmp-fmkso1x2/src/hw/ppc/spa=
pr_rtas.c:42:0:
> ../qapi-event.h:48:6: note: declared here
>  void qapi_event_send_guest_panicked(GuestPanicAction action, bool has_in=
fo, GuestPanicInformation *info, Error **errp);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-fmkso1x2/src/rules.mak:69: recipe for target =
'hw/ppc/spapr_rtas.o' failed
> make[1]: *** [hw/ppc/spapr_rtas.o] Error 1
> Makefile:318: recipe for target 'subdir-ppc64-softmmu' failed
>
oops. will check other arches and resubmit. My fault.

Den
