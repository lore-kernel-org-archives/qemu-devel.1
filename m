Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C249DC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 06:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CFE214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 06:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CFE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd7IS-0007vG-It
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 02:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35676)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hd7HX-0007K2-L0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 02:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hd7HW-0007Ja-Dw
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 02:07:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hd7HW-0007Ig-6M
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 02:07:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9AF6D81F18;
 Tue, 18 Jun 2019 06:07:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29DB360BF1;
 Tue, 18 Jun 2019 06:07:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9431611386A6; Tue, 18 Jun 2019 08:07:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190617184903.19436-1-armbru@redhat.com>
 <CAFEAcA9M0kEikXajCWX9BUtLU87P6=KHvbEWoW6xVq0Y7xvueQ@mail.gmail.com>
Date: Tue, 18 Jun 2019 08:07:42 +0200
In-Reply-To: <CAFEAcA9M0kEikXajCWX9BUtLU87P6=KHvbEWoW6xVq0Y7xvueQ@mail.gmail.com>
 (Peter Maydell's message of "Mon, 17 Jun 2019 19:58:09 +0100")
Message-ID: <87blyvzas1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 18 Jun 2019 06:07:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/16] Monitor patches for 2019-06-17
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 17 Jun 2019 at 19:51, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> The following changes since commit 076243ffe6c1b687e9e6d98348c3bf3398df7=
8f3:
>>
>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20190617=
' into staging (2019-06-17 16:41:25 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2019-06-17
>>
>> for you to fetch changes up to 092b8737c5e7695c4b9caa3b4eedc66763632755:
>>
>>   vl: Deprecate -mon pretty=3D... for HMP monitors (2019-06-17 20:36:56 =
+0200)
>>
>> ----------------------------------------------------------------
>> Monitor patches for 2019-06-17
>>
>
> Hi; I'm afraid this doesn't compile:
>
> Most hosts (ppc64, s390, aarch64, aarch32, osx, and possibly
> the others too though they haven't failed immediately) fail
> something like this:
>
> /home/pm215/qemu/monitor/misc.c: In function =E2=80=98netdev_del_completi=
on=E2=80=99:
> /home/pm215/qemu/monitor/misc.c:2165:9: error: implicit declaration of
> function =E2=80=98qemu_find_opts_err=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
>          opts =3D qemu_opts_find(qemu_find_opts_err("netdev", NULL), name=
);
>          ^
> /home/pm215/qemu/monitor/misc.c:2165:9: error: nested extern
> declaration of =E2=80=98qemu_find_opts_err=E2=80=99 [-Werror=3Dnested-ext=
erns]
> /home/pm215/qemu/monitor/misc.c:2165:9: error: passing argument 1 of
> =E2=80=98qemu_opts_find=E2=80=99 makes pointer from integer without a cas=
t [-Werror]
> In file included from /home/pm215/qemu/monitor/misc.c:64:0:
> /home/pm215/qemu/include/qemu/option.h:105:11: note: expected =E2=80=98st=
ruct
> QemuOptsList *=E2=80=99 but argument is of type =E2=80=98int=E2=80=99
>  QemuOpts *qemu_opts_find(QemuOptsList *list, const char *id);
>            ^
> cc1: all warnings being treated as errors

Yup, my fault: I fell into the trap laid by include/ui/qemu-spice.h,
which includes qemu/config-file.h only when CONFIG_SPICE.

> windows is a bit different:
>
> /home/petmay01/qemu-for-merges/monitor/hmp.c: In function 'file_completio=
n':
> /home/petmay01/qemu-for-merges/monitor/hmp.c:1113:5: error: unknown
> type name 'DIR'
>      DIR *ffs;
>      ^
> /home/petmay01/qemu-for-merges/monitor/hmp.c:1135:11: error: implicit
> declaration of function 'opendir'
> [-Werror=3Dimplicit-function-declaration]
>      ffs =3D opendir(path);
>            ^
> /home/petmay01/qemu-for-merges/monitor/hmp.c:1135:5: error: nested
> extern declaration of 'opendir' [-Werror=3Dnested-externs]
>      ffs =3D opendir(path);
>      ^
> /home/petmay01/qemu-for-merges/monitor/hmp.c:1135:9: error: assignment
> makes pointer from integer without a cast [-Werror=3Dint-conversion]
>      ffs =3D opendir(path);
>          ^
> /home/petmay01/qemu-for-merges/monitor/hmp.c:1141:13: error: implicit
> declaration of function 'readdir'
> [-Werror=3Dimplicit-function-declaration]
>          d =3D readdir(ffs);
>              ^
> /home/petmay01/qemu-for-merges/monitor/hmp.c:1141:9: error: nested
> extern declaration of 'readdir' [-Werror=3Dnested-externs]
>          d =3D readdir(ffs);
>          ^
> /home/petmay01/qemu-for-merges/monitor/hmp.c:1141:11: error:
> assignment makes pointer from integer without a cast
> [-Werror=3Dint-conversion]
>          d =3D readdir(ffs);
>            ^
> /home/petmay01/qemu-for-merges/monitor/hmp.c:1146:21: error:
> dereferencing pointer to incomplete type 'struct dirent'
>          if (strcmp(d->d_name, ".") =3D=3D 0 || strcmp(d->d_name, "..") =
=3D=3D 0) {
>                      ^
> /home/petmay01/qemu-for-merges/monitor/hmp.c:1166:5: error: implicit
> declaration of function 'closedir'
> [-Werror=3Dimplicit-function-declaration]
>      closedir(ffs);
>      ^
> /home/petmay01/qemu-for-merges/monitor/hmp.c:1166:5: error: nested
> extern declaration of 'closedir' [-Werror=3Dnested-externs]

Here, Kevin fell into the trap laid by GLib, which includes <dirent.h>
only #ifdef G_OS_UNIX.

v2 coming up.

