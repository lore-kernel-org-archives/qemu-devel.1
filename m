Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B6DC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 16:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031BD206ED
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 16:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E6TAsGbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031BD206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbnrr-0006WR-5x
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 11:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kbnqu-0005or-5c
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 11:47:41 -0500
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com
 ([40.107.244.46]:54977 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kbnqr-0004Lq-Uv
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 11:47:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTDLkiigZAGaX7jfNMP+vd0s+WTh/48Ngd58l23lkzPuLAVtV8KVY/07kxyAu6vscJ6/qHTl+PeAnGNCnddonk3d0eGWGJRTOztAaANSSHAOVBQHKSevPW12RRbucc3Nj3M7ao0ftIWFOajQW78wG/VgoyxJaUXlm9UBS9S3vzRqo3V7BDz2KstP5fniotcGO3rmWl7UXr7kvgfC4EEFQ1pTPRJWIbVUTFPFEDqIwpOd6pCp/Mpx6qmg6NEUkzxE6FHNZyOQQcv0BcUQsVRaC9jQ7jpFPhrifCcEhKxMsGHGNvaTCeSSAQv0I2wVvK+QcoJfYadozwbbDx5OSP6c7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS/mXQCPRxGXLOoVyXf4+zMQs9gIkQULrg1HJXBnwXM=;
 b=Cuxg1VmqGByY/ZrJE+M8H2b66FsLlndxkpkeZob3/F3/XXPHViWZlUhU/t2etPa5dKqY8fH8UErmXx2jIC15o0FXZ1/Y378dMPWkQQT6urMiw0GsDV5UvVW6YEYS8PgJwPS0bxEbpoheDx4FFYBDzBXGTRZIgohIGH5QqVnVU5gGqvLZE07Ia1oIX7I7AVqT8kewv8FRyrURDg83Gf52mj++Ma2UqFyIVKWI367j5ugMeNZ0Ce73LHC+awSsaFPs+AHbKfgkhmEJboKr0eckIM6nMauPmExVLNqcmWQlZogc9W3Vsuud8cD+yRqsoLoe9b378X/m2CJayIhPKW4Tsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS/mXQCPRxGXLOoVyXf4+zMQs9gIkQULrg1HJXBnwXM=;
 b=E6TAsGbHW5caoyN3rI/duTL58rnCw5qJKC8o/Oc1GPbQiHgH8frD567MnHlJlx8Rlm0PmaLW7AI3B+il28FT4KpsyQjhr5OV62y0g61UEZKCgBLmvsoTLh03gce6ggI8wTqioBcQKhv1t6nEVPfWPUXyDPb7BzfFHjFD9h5njWw=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 16:47:33 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3541.025; Sun, 8 Nov 2020
 16:47:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <00608db2-f19e-c6b7-a832-9e65fd4c7462@redhat.com>
References: <20201103024343.894221-1-michael.roth@amd.com>
 <20201103024343.894221-6-michael.roth@amd.com>
 <00608db2-f19e-c6b7-a832-9e65fd4c7462@redhat.com>
Subject: Re: [PULL v3 05/12] qga: add command guest-get-disks
From: Michael Roth <michael.roth@amd.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 08 Nov 2020 10:47:23 -0600
Message-ID: <160485404311.188051.2037056149469049533@vm0>
User-Agent: alot/0.9
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SN4PR0501CA0121.namprd05.prod.outlook.com
 (2603:10b6:803:42::38) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SN4PR0501CA0121.namprd05.prod.outlook.com (2603:10b6:803:42::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend
 Transport; Sun, 8 Nov 2020 16:47:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 445f4d89-2d48-4b74-62f3-08d88405fcf7
X-MS-TrafficTypeDiagnostic: CH2PR12MB4168:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4168E39D542783B83FD9434895EB0@CH2PR12MB4168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2fL+EGX1dxGo8DjIReQxfYDuJGEyryV66vxqWbNzp6DpaDhaVl1qza0OaKtg7XN8s4f0aNFCQiGtPnNTTtHN/512QgGunPdqgStfG2Ff3PwtGkA6OFVfrnMbL437ZeolhXr8Pr3N/rkV70GQ/cquyXkC6VEuA0veixyP1ya2UN0T4b5KKgt1vQs0RETS0UHDX4q9YTjlsC5kg0L3uggqTZSY5njNgA074rFwwF3yYEPndcXWnH5lmm9Bemqk/hWXMVbCazLAA4QrQU2hz5WXwZdjG2dxiEhWfRgZVkPxYCojFTrxEslVoDce/7WpUt2F8t5/Vl5PmXe6SZnTw5ZfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(7916004)(346002)(39860400002)(396003)(136003)(366004)(376002)(8936002)(86362001)(26005)(186003)(53546011)(16526019)(8676002)(33716001)(44832011)(956004)(83380400001)(6496006)(52116002)(54906003)(316002)(4326008)(2906002)(478600001)(6486002)(66476007)(9686003)(6666004)(66946007)(5660300002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3osLW0y6ip1E/pZK60D/ZRvXCvPriBM6gSboMVc0zPecxvz2PR/ML8hpMLb2B+VjyhSe3LcoFviVFL1XyAD05xsbYHct5xTITX0oM5Lcz2iA65GmkPBxTRw6bPKqsPYN6/oZr8Xy2LXdEigWwH8qjd+YEw34sgKi4wyyJBmNKExQzw84l96Nju+dxQrhrSbLSlqbCctFPi2fZ9chBJVOEY6Cmnh3+p4ho17OamEhSycv60YQ/i41lMCA2OTVzOfws5EOgvtmkUxZSRlzMExosa6+6/scDwK1+PHmEu6lyHcoPPLnztM5PzWi0Mh740PI6Q+ihgw/4UGOel5IWJ6myMakSipHmbctYuf6XYyphC5msLc4g6CCCcHN/fOvgaiwPn5i5+W6MQGlnMMs4ysnl9xFJTdST3qlyixVwrueDNfKrduK4WVqyrV7zC8kB6NvS2A2n815rIeg0KZ/uV8O59H6k4GRvXiw+yh6x2yoag1pU7+cgqPH6PvBwl1L+7ajA9YFdoWhkMWfN1Va9pu0uOcPJIBbWnHNQs8ipbhMJINNUl4EKD4ywkj9Pul5qvzIQDyGN/PrN5W04q0toVQDjS1xvpGJGowPgbZnHoI37Vjce69g/6dPXA57r/+S4FIC+BOJBQPGT9vzsE7OAV7OsTsbXzZrBjhO2dOjE9oQHg/JMAx34TJejOpEt0IahDDZqutFhDsBekc6g+Sj4oaW/NvSk7JLmioyxZ5yUtyeReYPyobLvncLt+j4kZH4A1D4upnMtcTLEZyqKPvc9HCv1K55cWESpIiuKubDg7uJWSTbda9x3HKr5Si/MMlPCGJNEHS5rMOzfUXT3VhMKRtl1H1N2xL+OSWIevMx75/q/vQELmZYSj/uMqHLforRZgClG9imN8SV746xIEJBQbwW5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445f4d89-2d48-4b74-62f3-08d88405fcf7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 16:47:32.9795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th3qDDGgc6V0n7fpnwtUMvYUsniNQTJWqy8qTDHVOaG46qKhvd68tyx7pZtsmtKFLjKKXGuNjqvKAFyHVpHm0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
Received-SPF: none client-ip=40.107.244.46; envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 11:47:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1.299, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, Tomáš Golembiovský <tgolembi@redhat.com>, Philippe Mathieu-Daudé <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marc-André Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Eric Blake (2020-11-04 15:56:17)
> [Adding Markus in CC]
>=20
> On 11/2/20 8:43 PM, Michael Roth wrote:
> > From: Tom=C3=A1\u0161 Golembiovsk=C3=BD <tgolembi@redhat.com>
> >=20
> > Add API and stubs for new guest-get-disks command.
> >=20
> > The command guest-get-fsinfo can be used to list information about disk=
s
> > and partitions but it is limited only to mounted disks with filesystem.
> > This new command should allow listing information about disks of the VM
> > regardles whether they are mounted or not. This can be usefull for
> > management applications for mapping virtualized devices or pass-through
> > devices to device names in the guest OS.
> >=20
> > Signed-off-by: Tom=C3=A1\u0161 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >  qga/commands-posix.c |  6 ++++++
> >  qga/commands-win32.c |  6 ++++++
> >  qga/qapi-schema.json | 31 +++++++++++++++++++++++++++++++
> >  3 files changed, 43 insertions(+)
>=20
> I know my review is late, since the PR is already accepted, but some
> items that may be worth followup patches in the 5.2 cycle:
>=20
>=20
> > +++ b/qga/qapi-schema.json
> > @@ -865,6 +865,37 @@
> >             'bus': 'int', 'target': 'int', 'unit': 'int',
> >             '*serial': 'str', '*dev': 'str'} }
> > =20
> > +##
> > +# @GuestDiskInfo:
> > +#
> > +# @name: device node (Linux) or device UNC (Windows)
> > +# @partition: whether this is a partition or disk
> > +# @dependents: list of dependent devices; e.g. for LVs of the LVM this=
 will
> > +#              hold the list of PVs, for LUKS encrypted volume this wi=
ll
> > +#              contain the disk where the volume is placed.     (Linux=
)
>=20
> Odd spacing before the comment.
>=20
> Should @dependents be guarded by 'if', or are we avoiding the use of
> 'if' in qga for now and only using it in qmp?

Marc-Andr=C3=A9's recent guest-ssh-{get,add,remove}-authorized-keys patches=
 are
the first users for qga I think. The CONFIG_{LINUX,POSIX,W32} is
becoming pretty unwieldly so I've been planning on going back and using
schema conditionals and refactoring things a bit anyway so I'm ok with
adding it later as long as the documentation is accurate.

>=20
> Is 'dependents' the right name?  A common English use of 'dependent' is
> when talking about a family: a parent's child is their dependent (that
> is, a dependent tends to be the smaller entity).  But here, you are
> using the term in the opposite direction: this storage device (such as a
> LUKS encrypted drive) is declaraing a LARGER entity (the containing
> block device) as its dependent.  Would 'dependencies' or 'depends-on' be
> more accurate?

Agreed, 'dependencies' is probably a better name. The 'slaves' term
used in /sys can be a bit confusing in this regard as well, but
captures the relationship a bit better than 'dependents' as least.

>=20
> > +# @address: disk address information (only for non-virtual devices)
> > +# @alias: optional alias assigned to the disk, on Linux this is a name=
 assigned
> > +#         by device mapper
> > +#
> > +# Since 5.2
> > +##
> > +{ 'struct': 'GuestDiskInfo',
> > +  'data': {'name': 'str', 'partition': 'bool', 'dependents': ['str'],
> > +           '*address': 'GuestDiskAddress', '*alias': 'str'} }
>=20
> 'dependents' is not an optional member, but documented as '(Linux)'
> above; does that mean you always get "dependents":[] on the wire for
> Windows, rather than omitting the field?

Yes, which seems a bit misleading to management. This should be made
optional.

I'll send a patch to address these.

Thanks for the review!

-Mike

>=20
> > +
> > +##
> > +# @guest-get-disks:
> > +#
> > +# Returns: The list of disks in the guest. For Windows these are only =
the
> > +#          physical disks. On Linux these are all root block devices o=
f
> > +#          non-zero size including e.g. removable devices, loop device=
s,
> > +#          NBD, etc.
> > +#
> > +# Since: 5.2
> > +##
> > +{ 'command': 'guest-get-disks',
> > +  'returns': ['GuestDiskInfo'] }
> > +
> >  ##
> >  # @GuestFilesystemInfo:
> >  #
> >=20
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>=20
>

