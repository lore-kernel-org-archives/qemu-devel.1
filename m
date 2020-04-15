Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE07BC2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 00:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEA42072D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 00:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEA42072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOVjI-0000qr-Rx
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 20:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jOViV-0000PJ-OP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jOViU-000643-3x
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:15:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:39170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jOViT-000628-Ur
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:15:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jOViS-0005OE-Ej
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:15:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 68FEF2E8108
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:15:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2020 00:08:39 -0000
From: Barnabas Viragh <1860553@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cyborgyn glaubitz laurent-vivier rth
X-Launchpad-Bug-Reporter: John Paul Adrian Glaubitz (glaubitz)
X-Launchpad-Bug-Modifier: Barnabas Viragh (cyborgyn)
References: <157970117843.5560.13252417721225198010.malonedeb@chaenomeles.canonical.com>
Message-Id: <158690931998.5950.8180907219600396248.malone@chaenomeles.canonical.com>
Subject: [Bug 1860553] Re: cmake crashes on qemu-alpha-user with Illegal
 Instruction
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 39781a7735843968201343988cd2b652591d0adc
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1860553 <1860553@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It also produces that Illegal Instruction on Gentoo. However, the exact
same cmake binary runs without issue on real hardware.

Some additions: qemu-mips64, qemu-arm, qemu-aarch64 doesn't have this
problem (I'am using it with the same version of cmake compiled to/under
those, and real HW).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1860553

Title:
  cmake crashes on qemu-alpha-user with Illegal Instruction

Status in QEMU:
  New

Bug description:
  I tried building cmake on Debian unstable for Alpha today using qemu-
  user and the compiled cmake binary crashed with "Illegal Instruction":

  g++ -Wl,-z,relro -Wl,--as-needed -g -O2 -fdebug-prefix-map=3D/<<PKGBUILDD=
IR>>=3D. -Wformat -Werror=3Dformat-security -Wdate-time -D_FORTIFY_SOURCE=
=3D2             -I/<<PKGBUILDDIR>>/Build/Bootstrap.cmk   -I/<<PKGBUILDDIR>=
>/Source   -I/<<PKGBUILDDIR>>/Source/LexerParser   -I/<<PKGBUILDDIR>>/Utili=
ties  cmAddCustomCommandCommand.o cmAddCustomTargetCommand.o cmAddDefinitio=
nsCommand.o cmAddDependenciesCommand.o cmAddExecutableCommand.o cmAddLibrar=
yCommand.o cmAddSubDirectoryCommand.o cmAddTestCommand.o cmArgumentParser.o=
 cmBreakCommand.o cmBuildCommand.o cmCMakeMinimumRequired.o cmCMakePolicyCo=
mmand.o cmCPackPropertiesGenerator.o cmCacheManager.o cmCommand.o cmCommand=
ArgumentParserHelper.o cmCommands.o cmCommonTargetGenerator.o cmComputeComp=
onentGraph.o cmComputeLinkDepends.o cmComputeLinkInformation.o cmComputeTar=
getDepends.o cmConditionEvaluator.o cmConfigureFileCommand.o cmContinueComm=
and.o cmCoreTryCompile.o cmCreateTestSourceList.o cmCustomCommand.o cmCusto=
mCommandGenerator.o cmDefinePropertyCommand.o cmDefinitions.o cmDepends.o c=
mDependsC.o cmDisallowedCommand.o cmDocumentationFormatter.o cmEnableLangua=
geCommand.o cmEnableTestingCommand.o cmExecProgramCommand.o cmExecuteProces=
sCommand.o cmExpandedCommandArgument.o cmExportBuildFileGenerator.o cmExpor=
tFileGenerator.o cmExportInstallFileGenerator.o cmExportSet.o cmExportSetMa=
p.o cmExportTryCompileFileGenerator.o cmExprParserHelper.o cmExternalMakefi=
leProjectGenerator.o cmFileCommand.o cmFileCopier.o cmFileInstaller.o cmFil=
eTime.o cmFileTimeCache.o cmFileTimes.o cmFindBase.o cmFindCommon.o cmFindF=
ileCommand.o cmFindLibraryCommand.o cmFindPackageCommand.o cmFindPathComman=
d.o cmFindProgramCommand.o cmForEachCommand.o cmFunctionCommand.o cmFSPermi=
ssions.o cmGeneratedFileStream.o cmGeneratorExpression.o cmGeneratorExpress=
ionContext.o cmGeneratorExpressionDAGChecker.o cmGeneratorExpressionEvaluat=
ionFile.o cmGeneratorExpressionEvaluator.o cmGeneratorExpressionLexer.o cmG=
eneratorExpressionNode.o cmGeneratorExpressionParser.o cmGeneratorTarget.o =
cmGetCMakePropertyCommand.o cmGetDirectoryPropertyCommand.o cmGetFilenameCo=
mponentCommand.o cmGetPipes.o cmGetPropertyCommand.o cmGetSourceFilePropert=
yCommand.o cmGetTargetPropertyCommand.o cmGetTestPropertyCommand.o cmGlobal=
CommonGenerator.o cmGlobalGenerator.o cmGlobalUnixMakefileGenerator3.o cmGl=
obVerificationManager.o cmHexFileConverter.o cmIfCommand.o cmIncludeCommand=
.o cmIncludeGuardCommand.o cmIncludeDirectoryCommand.o cmIncludeRegularExpr=
essionCommand.o cmInstallCommand.o cmInstallCommandArguments.o cmInstallDir=
ectoryGenerator.o cmInstallExportGenerator.o cmInstallFilesCommand.o cmInst=
allFilesGenerator.o cmInstallGenerator.o cmInstallScriptGenerator.o cmInsta=
llSubdirectoryGenerator.o cmInstallTargetGenerator.o cmInstallTargetsComman=
d.o cmInstalledFile.o cmLinkDirectoriesCommand.o cmLinkItem.o cmLinkLineCom=
puter.o cmLinkLineDeviceComputer.o cmListCommand.o cmListFileCache.o cmLoca=
lCommonGenerator.o cmLocalGenerator.o cmLocalUnixMakefileGenerator3.o cmMSV=
C60LinkLineComputer.o cmMacroCommand.o cmMakeDirectoryCommand.o cmMakefile.=
o cmMakefileExecutableTargetGenerator.o cmMakefileLibraryTargetGenerator.o =
cmMakefileTargetGenerator.o cmMakefileUtilityTargetGenerator.o cmMarkAsAdva=
ncedCommand.o cmMathCommand.o cmMessageCommand.o cmMessenger.o cmNewLineSty=
le.o cmOSXBundleGenerator.o cmOptionCommand.o cmOrderDirectories.o cmOutput=
Converter.o cmParseArgumentsCommand.o cmPathLabel.o cmPolicies.o cmProcessO=
utput.o cmProjectCommand.o cmProperty.o cmPropertyDefinition.o cmPropertyDe=
finitionMap.o cmPropertyMap.o cmReturnCommand.o cmRulePlaceholderExpander.o=
 cmScriptGenerator.o cmSearchPath.o cmSeparateArgumentsCommand.o cmSetComma=
nd.o cmSetDirectoryPropertiesCommand.o cmSetPropertyCommand.o cmSetSourceFi=
lesPropertiesCommand.o cmSetTargetPropertiesCommand.o cmSetTestsPropertiesC=
ommand.o cmSiteNameCommand.o cmSourceFile.o cmSourceFileLocation.o cmState.=
o cmStateDirectory.o cmStateSnapshot.o cmStringReplaceHelper.o cmStringComm=
and.o cmSubdirCommand.o cmSystemTools.o cmTarget.o cmTargetCompileDefinitio=
nsCommand.o cmTargetCompileFeaturesCommand.o cmTargetCompileOptionsCommand.=
o cmTargetIncludeDirectoriesCommand.o cmTargetLinkLibrariesCommand.o cmTarg=
etPropCommandBase.o cmTargetPropertyComputer.o cmTargetSourcesCommand.o cmT=
est.o cmTestGenerator.o cmTimestamp.o cmTryCompileCommand.o cmTryRunCommand=
.o cmUnexpectedCommand.o cmUnsetCommand.o cmUVHandlePtr.o cmUVProcessChain.=
o cmVersion.o cmWhileCommand.o cmWorkingDirectory.o cmake.o cmakemain.o cmc=
md.o cm_string_view.o cmCommandArgumentLexer.o cmCommandArgumentParser.o cm=
ExprLexer.o cmExprParser.o cmListFileLexer.o Directory.o EncodingCXX.o FStr=
eam.o Glob.o RegularExpression.o SystemTools.o EncodingC.o ProcessUNIX.o St=
ring.o System.o Terminal.o uv-src-strscpy.c.o uv-src-timer.c.o uv-src-uv-co=
mmon.c.o uv-src-unix-cmake-bootstrap.c.o uv-src-unix-core.c.o uv-src-unix-f=
s.c.o uv-src-unix-loop.c.o uv-src-unix-loop-watcher.c.o uv-src-unix-no-fsev=
ents.c.o uv-src-unix-pipe.c.o uv-src-unix-poll.c.o uv-src-unix-posix-hrtime=
.c.o uv-src-unix-posix-poll.c.o uv-src-unix-process.c.o uv-src-unix-signal.=
c.o uv-src-unix-stream.c.o  -ldl -lrt -o cmake
  make[2]: Leaving directory '/<<PKGBUILDDIR>>/Build/Bootstrap.cmk'
  loading initial cache file /<<PKGBUILDDIR>>/Build/Bootstrap.cmk/InitialCa=
cheFlags.cmake
  Illegal instruction
  ---------------------------------------------
  Error when bootstrapping CMake:
  Problem while running initial CMake
  ---------------------------------------------

  I'm working on creating a chroot for download to reproduce the issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1860553/+subscriptions

