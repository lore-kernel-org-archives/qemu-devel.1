Received: from eggs.gnu.org ([2001:4830:134:3::10]:55032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxsJu-0002Lq-Ne
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxsJt-0008Qa-Uj
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:42:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
	<0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
	<ef9e10c4-3986-32ba-da2d-1b8f71d58319@redhat.com>
	<20170404132815.aactqo2o5izpzclf@eukaryote>
	<8420253d-261f-f040-6815-c949b8a2cce2@redhat.com>
Date: Tue, 11 Apr 2017 11:42:28 +0200
In-Reply-To: <8420253d-261f-f040-6815-c949b8a2cce2@redhat.com> (Eric Blake's
	message of "Tue, 4 Apr 2017 08:54:50 -0500")
Message-ID: <877f2rcmbf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] Making QMP 'block-job-cancel'
 transactionable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 04/04/2017 08:28 AM, Kashyap Chamarthy wrote:
>
>>> Minor or not, it is a useful viewpoint. Either way, as long as the new
>>> way of getting a transactional non-pivot successful completion is
>>> something that libvirt can learn via introspection, 
>> 
>> Can you elaborate a little more on the above, for my own edification --
>> how might it be possible for "libvirt can learn via introspection"?  Is
>> it via some method using the QMP 'query-commands' /
>> 'query-command-line-options'?
>
> Those, and query-qmp-schema.

Avoid query-command-line-options if you can.  If you can't, know its
limitations and quirks.

>                               If the change includes the addition of
> something new in the .json files describing QMP, then query-qmp-schema
> will let libvirt probe whether the version of qemu it it talking to has
> that new field or not (presumably, in this case it would be a new
> optional bool member to select the mode when creating a job, as well as
> a new command visible through query-commands to change the mode of a
> running job).
