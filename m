Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECF3C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698882077B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Avyyagqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698882077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iel4J-0000ig-LJ
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 14:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1iel3B-0008GD-DP
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1iel36-000237-MU
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:20:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40420
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1iel36-00022q-Hd
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576005595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9y4f1j3Q9zJ0LXu2Flxuh/ZBFAMc71KHncozRe4p6LE=;
 b=Avyyagqn1VUg0IdSw/LgsUp/vLyXuSP/1YRUebbWmytjEzYrZUHQBLS/3pHhZMXpXvJ+Qn
 rtJWjIF8GPkfXIX/RvTgU6huEp4tVwcZSaYGwZq9B2V2HLq2rVyoxEivXVWakrQldvOTR6
 rKCt7cE1uGyEAdlN0cm1PLG1ziAHaH8=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-25hM_rG2MyehtsMJGRViww-1; Tue, 10 Dec 2019 14:19:52 -0500
Received: by mail-ua1-f69.google.com with SMTP id l3so5336464uan.15
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 11:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9y4f1j3Q9zJ0LXu2Flxuh/ZBFAMc71KHncozRe4p6LE=;
 b=c616Rnf+9Mu5eSRyqPSZvdal3T/C6X0fcee7oAaiwZ2rYVTJDA97pL0V31A/I5GXsR
 VrosRzJfz59xTrQquXeGqSElFptNOEKa0asBtrgcobMGHIFwbGJCfknrUu9MX7eM5FdY
 JInpyx5xcECsIir6bSZ2wGZkgduCtmoAUTBSN69s4oRFPqJa9TifB99NZ9U/nmMyPtGT
 d47ZbzAhkahJSwClvUSV9tRARK85TyiFVICJvDVl6SX6nTjWM4VqpKxwrsDD8lfqrMXb
 ES4Gp17OLXtTwAs8ix348lJD+xX4zLfnCTWxp4rjPZ6iaWbFlJjW+PTdA7kqJke/GxE9
 P8Gg==
X-Gm-Message-State: APjAAAVivQEFjSWTACDs19Xh9Mw5OprTIj+0kgCzCJP5oXlCncg2cKQT
 ibW4tv0Zkqi86CRKYMC7EKSTor1EI5YW4jtCCM+dccV/J16DjFDWrzOMsgNT4d/E3UKKr4NW79W
 NkXNxR6z6Qgbc5myaldTZfTOyPnp/zTI=
X-Received: by 2002:a05:6102:2337:: with SMTP id
 b23mr26316590vsa.48.1576005591603; 
 Tue, 10 Dec 2019 11:19:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvBvkSGhHwuqnsX1ocfE/CRQYCtM0pBWOU/KJ80gUKNh313qTiNgNmFVFJywqh7LTXdrTvrKqzjRCyg0GVVUk=
X-Received: by 2002:a05:6102:2337:: with SMTP id
 b23mr26316566vsa.48.1576005591219; 
 Tue, 10 Dec 2019 11:19:51 -0800 (PST)
MIME-Version: 1.0
References: <9b3b2ff0-a3bb-c7ba-d7ce-d178e8fbd5d8@redhat.com>
 <20191125135802.GH4438@habkost.net>
 <20191125180818.GB8589@localhost.localdomain>
In-Reply-To: <20191125180818.GB8589@localhost.localdomain>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 10 Dec 2019 16:19:40 -0300
Message-ID: <CAKJDGDaVjZQ6gTVkXO-vAkkHbUruGSNOKm32AH0-Qp_Ywnde9g@mail.gmail.com>
Subject: Re: Avocado notes from KVM forum 2019
To: Cleber Rosa <crosa@redhat.com>
X-MC-Unique: 25hM_rG2MyehtsMJGRViww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 avocado-devel <avocado-devel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 3:10 PM Cleber Rosa <crosa@redhat.com> wrote:
>
> On Mon, Nov 25, 2019 at 10:58:02AM -0300, Eduardo Habkost wrote:
> > Thank you, Philippe, those are great ideas.  I have copied them
> > to the Avocado+QEMU Trello board so we don't forget about them:
> > https://trello.com/b/6Qi1pxVn/avocado-qemu
> >
> > Additional comments below:
> >
> > On Mon, Nov 25, 2019 at 01:35:13PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > Hi Cleber,
> > >
> > > Here are my notes from talking about Avocado with various people duri=
ng the
> > > KVM forum in Lyon last month.
> > >
> > > All comments are QEMU oriented.
> > >
> > >
> > > 1) Working offline
> > >
> > > Various people complained Avocado requires online access, and they wo=
uld
> > > like to use it offline.
> > >
> > >   Maintainer workflow example is:
> > >
> > >   - run avocado
> > >   - hack QEMU, build
> > >   - git pull
> > >   - build
> > >   - hack QEMU
> > >   (go offline)
> > >   - hack QEMU
> > >   - build
> > >   - run avocado <- FAILS
> > >
> >
> > Ouch.  This shouldn't happen even with no explicit --offline
> > option.  Failure to download artifacts shouldn't make tests
> > report failure.
> >
> >
>
> Agreed.  There are a number of work items already to cover this.  One
> is a more generic test metadata collection system:
>
>    https://trello.com/c/lumR8u8Y/1526-rfc-nrunner-extended-metadata
>
> We already have code that can find the required assets, and with that,
> we can let the job (not the test) attempt to fulfill those
> requirements, skipping the tests if they can not be fulfilled.
>
> Until this is available, we can wrap the "fetch_asset()" calls and
> cancel the test if it fails.
>
> > > Failure is because mainstream added new tests, which got pulled in, a=
nd the
> > > user only notice when running avocado again, but offline.
> > > Test example is boot_linux_console.py, which added various tests from=
 other
> > > subsystems, so the maintainer has to disable the new tests manually t=
o be
> > > able to run his previous tests.
> > >
> > > Expected solution: skip tests when artifact is not available, eventua=
lly
> > > when the --offline option is used
> > >
> > >
> > > 2) Add artifacts manually to the cache
> > >
> > > Not all artifacts can be easily downloadable, some are public but req=
uire
> > > the user to accept an End User License Agreement.
> > > Users would like to share their tests with the documentation about wh=
ere/how
> > > to download the requisite files (accepting the EULA) to run the tests=
.
> > >
> > >
> > > 2b) Add reference to artifact to the cache
> > >
> > > Group of users might share group of files (like NFS storage) and woul=
d like
> > > to use directly their remote read-only files, instead of copying it t=
o their
> > > home directory.
> >
> > This sounds nice and useful, but I don't know how to make the
> > interface for this usable.
> >
> >
>
> I guess this would require an Avocado installation-wide configuration
> entry for the available cache directories.  IMO given that
> configuration is applied, the tests should transparently find assets
> in the configured locations.
>
> > >
> > >
> > > 3) Provide qemu/avocado-qemu Python packages
> > >
> > > The mainstream project uses Avocado to test QEMU. Others projects use=
 QEMU
> > > to test their code, and would like to automatize that using Avocado. =
They
> > > usually not rebuild QEMU but use a stable binary from distributions. =
The
> > > python classes are not available, so they have to clone QEMU to use A=
vocado
> > > (I guess they only need 5 python files).
> > > When running on Continuous Integration, this is overkill, because whe=
n you
> > > clone QEMU you also clone various other submodules.
> >
> > I only have one concern, here: I don't think we have the
> > bandwidth to start maintaining a stable external Python API.
> > Users of those packages will need to be aware that future
> > versions of the modules might have incompatible APIs.
> >
>
> My understanding is that we would publish those files as a Python
> module with versions matching QEMU.  No stability would be promised.
> Users can always require a specific version of the Python module that
> matches the QEMU version they expect/want to use.
>
> > >
> > >
> > > 4) Warn the user when Avocado is too old for the tests
> > >
> > > Some users tried Avocado following the examples on the mailing list a=
nd the
> > > one in some commit's descriptions where we simply show "avocado run .=
..".
> >
> > Oops.
> >
> > > They installed the distribution Avocado package and tried and it fail=
s for
> > > few of them with no obvious reason (the .log file is hard to read whe=
n you
> > > are not custom to). IIUC their distribution provides a older Avocado =
(69?)
> > > while we use recent features (72).
> > >
> > > We never noticed it because we use 'make check-venv' and do not test =
the
> > > distrib Avocado. While we can not test all distribs, we could add a v=
ersion
> > > test if the Avocado version is too old, display a friendly message to=
 the
> > > console (not the logfile).
> >
> > Sounds like a good idea.
> >
>
> A simpler (complementary?) solution, or maybe just a good practice, is
> to try to use in the examples:
>
>   "./tests/venv/bin/avocado run ..."
>
> Do you think this would be enough?  It would of course not cover the
> examples in previous commit messages.
>
> Thanks!
> - Cleber.
>
> > >
> > >
> > > That it for my notes.
> > >
> > > Eduardo/Wainer, are there other topics I forgot?
> >
> > I don't remember anything specific right now.  Thanks again!
> >
> > --
> > Eduardo
>
>

Following up with this discussion, I'm gathering requirements for the
asset management architecture on Avocado.

So far, these are the use cases I could gather from e-mail
discussions, Avocado meetings, and individual talks followed by the
Trello board cards I found that may be related:

- Ability to skip a test when an asset is not available [4];
- Download the assets previous to the test start (covered on version
73 of Avocado):
    - Using the command line [5];
    - Or transparently to the test execution, during the pre-job
execution phase [6];
- Manually add an asset to the cache [8]:
    - By copying the asset to the cache;
    - By adding a reference to the cache, or maybe using a location
other than the cache;
- Reference an asset globally, like a module object accessible by
different tests [9];
- Collect assets from a test [1,3]

Following are the Trello Board cards I found on Avocado and Avocado +
QEMU boards related to assets:

Avocado Trello Board:

- Backlog:

[1] Add support to specify assets in test docstring -
https://trello.com/c/WPd4FrIy/1479-add-support-to-specify-assets-in-test-do=
cstring
[2] Asset Fetcher: avoid recalculation of cached hash and locking
errors - https://trello.com/c/WdnjY4n7/1528-asset-fetcher-avoid-recalculati=
on-of-cached-hash-and-locking-errors
[3] RFC: NRunner: extended metadata -
https://trello.com/c/lumR8u8Y/1526-rfc-nrunner-extended-metadata

- Work in progress:

[4] On cache check for asset fetcher -
https://trello.com/c/CKP7YS6G/1481-on-cache-check-for-asset-fetcher

- Completed:

[5] Implement fetch-assets command line -
https://trello.com/c/T3SC1sZs/1521-implement-fetch-assets-command-line
[6] Extend Assets plugin to run the fetch during JobPreTests -
https://trello.com/c/jcqChIqN/1531-extend-assets-plugin-to-run-the-fetch-du=
ring-jobpretests


Avocado + QEMU Trello Board:

- Backlog:

[7] Mirror fedora/debian images on
https://avocado-project.org/data/assets/ -
https://trello.com/c/vY8eg0eZ/102-mirror-fedora-debian-images-on-https-avoc=
ado-projectorg-data-assets
[8] ability to add artifacts manually -
https://trello.com/c/czLc1Ouc/114-ability-to-add-artifacts-manually
[9] asset_library - https://trello.com/c/gJsXJz57/120-assetlibrary
[10] CI jobs shouldn't fail if image download fails -
https://trello.com/c/gJyVHCz2/122-ci-jobs-shouldnt-fail-if-image-download-f=
ails
[11] offline mode - https://trello.com/c/DRnMsEEZ/113-offline-mode

My objective is to create a parent tracking card on the Avocado Trello
board listing individual task-related cards mapped to the use case
requirements. As a start point, I will create the card tree with the
use cases I gathered and, later, add any other missing use cases that
we cover in this thread.

Any confirmation of use cases or proposals of other use cases is
appreciated to improve Avocado's ability to run your tests.


