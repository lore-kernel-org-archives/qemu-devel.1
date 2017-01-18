Received: from eggs.gnu.org ([2001:4830:134:3::10]:57430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cTtpw-0003tF-1d
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cTtpr-0008S3-06
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:15:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cTtpq-0008Re-QL
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:15:46 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 18 Jan 2017 18:15:44 +0100
Message-ID: <874m0wqofz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] SCSI HBA auto-created for -drive if=scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Some boards automatically cold-plug SCSI HBAs to honor -drive if=scsi.
Which one depends on the machine:

    pc*, realview-eb*, versatile*: lsi53c895a
    spapr-machine: spapr-vscsi

Should we use something less thoroughly obsolete than lsi53c895a for new
machine types?  Something that actually has a maintainer?
