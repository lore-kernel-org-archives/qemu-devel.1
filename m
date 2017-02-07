Received: from eggs.gnu.org ([2001:4830:134:3::10]:36674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1caz7J-0000FP-0S
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1caz7F-0005lU-UW
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:19:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1caz7F-0005kx-Oo
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:19:01 -0500
Date: Tue, 7 Feb 2017 14:18:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170207061856.GB19280@lemon.lan>
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

On Mon, 02/06 13:36, Eric Blake wrote:
> On 02/03/2017 05:57 AM, Pradeep Jagadeesh wrote:
> > This patchset adds the throttle support for the 9p-local driver.
> > For now this functionality can be enabled only through qemu cli options.
> > QMP interface and support to other drivers need further extensions.
> 
> This part is a bit scary - if 2.9 is released with just the cli option
> and not the QMP interface, then how does someone like libvirt introspect
> whether the feature is available for use?

Not that I want to make an unconstructive point, but just for understanding
this: if libvirt does introspect via QMP, is it technically okay to release CLI
in 2.9 and QMP in 2.10? libvirt can just ignore the possible existence of CLI
options if QMP is not there, no?

Fam
