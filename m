Received: from eggs.gnu.org ([2001:4830:134:3::10]:34609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJfmY-0002DC-5K
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJfmX-0002Fv-Fl
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:23:10 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181009132330.7549-7-berrange@redhat.com> ("Daniel
	P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 9 Oct 2018 14:23:30
	+0100")
References: <20181009132330.7549-1-berrange@redhat.com>
	<20181009132330.7549-7-berrange@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 05 Nov 2018 15:22:50 +0100
Message-ID: <87a7mnpps5.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/6] monitor: deprecate acl_show,
 acl_reset, acl_policy, acl_add, acl_remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>, =?utf-8?Q?Marc-?= =?utf-8?Q?Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> The various ACL related commands are obsolete now that the QAuthZ
> framework for authorization is fully integrated throughout QEMU network
> services. Mark it as deprecated with no replacement to be provided.
>
> Authorization is now provided by using 'object_add' together with
> the 'tls-authz' or 'sasl-authz' parameters to the VNC server, and
> equivalent for other network services.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
