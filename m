Received: from eggs.gnu.org ([2001:4830:134:3::10]:54171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVwak-0001Fs-V9
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVwah-0004Fu-TS
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:36:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVwah-0004Fo-NV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:36:35 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1484566314-3987-3-git-send-email-ashijeetacharya@gmail.com>
	(Ashijeet Acharya's message of "Mon, 16 Jan 2017 17:01:51 +0530")
References: <1484566314-3987-1-git-send-email-ashijeetacharya@gmail.com>
	<1484566314-3987-3-git-send-email-ashijeetacharya@gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jan 2017 09:36:30 +0100
Message-ID: <878tq0c0s1.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 2/5] migration: Add a new option to
 enable only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: dgilbert@redhat.com, jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:
> Add a new option "--only-migratable" in qemu which will allow to add
> only those devices which will not fail qemu after migration. Devices
> set with the flag 'unmigratable' cannot be added when this option will
> be used.
>
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I don't comment on the block code, as I don't know it well enough.
