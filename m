Received: from eggs.gnu.org ([209.51.188.92]:34523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIrwn-0000JA-6q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIrwd-0007lB-T9
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:42:35 -0400
Date: Tue, 23 Apr 2019 10:42:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190423094217.GC6022@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?question=EF=BC=9A_Does_qemu-pr-helper_hav?=
 =?utf-8?q?e_its_own_log_files=EF=BC=9F?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jie Wang <wangjie88@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>, "Fangyi (C)" <eric.fangyi@huawei.com>

On Tue, Apr 23, 2019 at 11:12:40AM +0800, Jie Wang wrote:
> =C2=A0Does qemu-pr-helper have its own log files=EF=BC=9F

When QEMU launches it, i think it just inherits stdout/err from
QEMU itself, so errors appear mixed into QEMU's stdout output.

When libvirt launches it, there stdout is connected to /dev/null
and stderr is connected to a pipe which libvirt closes almost
immediately. This means any errors are lost as any attempt to
write to stderr will get EPIPE :-(



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
